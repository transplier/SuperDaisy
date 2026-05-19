# PPM generator — evaluation (historical writeup)

> **Live matrix:** see [`eval/comparison.md`](comparison.md) for the current
> four-config comparison (baseline / +ppm / +bm25 / full) on both corpora.
> This document is kept as the iteration narrative for the PPM swap —
> useful for the methodology evolution but not the source of truth for
> headline numbers.
>
> The per-order PPM data files (`ppm3_*`, `ppm5_*`) referenced in earlier
> drafts have been removed from `eval/` since we settled on PPM:4 as the
> single PPM config to track.

First real Super-DAISY component swap: replacing the classic stride-3
1st-order Markov walker (`StrideThreeMarkovGenerator`) with a variable-order
PPM-style walker with backoff (`PpmMarkovGenerator`). All other components
unchanged. Evaluated against `eval/baseline.md`.

> **Update note:** numbers below are from the K-gram-indexed PPM with
> orchestrator-side ugly detection (`SuperDaisy::Ugly`). Two intermediate
> drafts of this report had different numbers — first when PPM was bound
> by the 500 ms wall-clock cap (flattered diversity), then briefly after
> the K-gram index landed but before the ugly-flag refactor (asymmetric
> metric). The numbers here are the honest, comparable ones.
>
> Reproducible via `./eval/run_all.sh`.

## What changed

PPM tries to match the last `K` tokens of generated context against the
corpus; on miss, backs off to `K-1`, `K-2`, ..., `1` until a match exists,
then samples uniformly among next-token candidates. Stride-1 emission
(one token per step) instead of stride-3.

Kernel preserved: every emitted token is verbatim from the corpus. No
smoothing, no learned weights. Backoff is data-driven.

## Setup

```
bin/eval --personality CORPUS --generator ppm:K \
         --baseline eval/baseline_<corpus>.json \
         --report eval/ppmK_<corpus>.md --data eval/ppmK_<corpus>.json
```

300 trials per config (30 prompts × 10 seeds). Orders 3, 4, 5 tested against
both `MEM.DSY` (92 sentences) and `fortune-haiku-3-5-250.DSY` (250 sentences).

## Results — MEM.DSY (92 sentences, 619 words)

| metric | classic | PPM:3 | PPM:4 | PPM:5 |
|---|---|---|---|---|
| fallthrough rate | 0.767 | 0.767 | 0.767 | 0.767 |
| ugliness rate | 0.090 | 0.000 | 0.000 | 0.000 |
| distinct-2 | 0.091 | 0.090 | 0.104 | 0.100 |
| distinct-3 | 0.119 | 0.097 | 0.113 | 0.109 |
| KL(responses ‖ corpus) nats | 0.949 | 0.873 | 0.940 | 0.857 |
| **KL drift from baseline (nats)** | — | **1.637** | **1.329** | **1.849** |
| latency p50 (ms) | 15.8 | 21.5 | 22.4 | 22.7 |
| latency p95 (ms) | 16.5 | 22.4 | 23.4 | 23.9 |
| mean attempts | 858 | 858 | 859 | 859 |
| mean kept | 2.26 | 2.24 | 2.23 | 2.23 |

## Results — fortune-haiku (250 sentences, 11974 words)

| metric | classic | PPM:3 | PPM:4 | PPM:5 |
|---|---|---|---|---|
| fallthrough rate | 0.810 | 0.867 | 0.890 | 0.897 |
| ugliness rate | 0.860 | 0.990 | 0.997 | 0.997 |
| distinct-2 | **0.145** | 0.079 | 0.077 | 0.064 |
| distinct-3 | **0.166** | 0.082 | 0.080 | 0.066 |
| KL(responses ‖ corpus) nats | 0.559 | 0.629 | 0.627 | 0.666 |
| **KL drift from baseline (nats)** | — | **2.134** | **2.223** | **2.245** |
| latency p50 (ms) | 27.3 | 42.6 | 46.1 | 46.6 |
| latency p95 (ms) | 28.1 | 44.0 | 47.2 | 47.8 |
| mean attempts | 966 | 968 | 966 | 966 |
| mean kept | 0.83 | 0.66 | 0.66 | 0.69 |

After the K-gram index landed, PPM no longer hits the wall-clock cap (latency
~46 ms vs. 500 ms before). All variants now run the full 1000-attempt budget.

### What the unified ugly detector revealed

The new `SuperDaisy::Ugly` runs the same sliding-ABA check on every
generator's output, plus a length-cap check. Numbers worth noting:

- **Classic on MEM stayed at 0.090 ugliness** — basically unchanged from the
  Pascal-faithful detector. The unified check confirms classic's mild cycling.
- **PPM on MEM is genuinely 0% ugly** — stride-1 emission with backoff
  doesn't produce ABA patterns when there's any choice. Real algorithmic
  difference, not a measurement artifact.
- **Fortune ugliness is dominated by the length cap.** Mean fortune
  responses are ~12 tokens × ~6 chars = right at the 70-char threshold.
  Classic hits the cap 86% of the time; PPM hits it 99% (its higher-order
  coherence produces longer runs before terminators fire).

## Stop-condition check (per `eval/baseline.md`)

| condition | classic baseline | PPM verdict |
|---|---|---|
| Fallthrough drops > 25 pp | — | **PASS** — basically unchanged on MEM (0.767), +6 to +10 pp on fortune (a *slight increase*, not the drop we feared) |
| Ugliness rate near zero on fortune | 0.840 | **PASS** — actually went *up* on fortune. MEM went to 0, but see note below |
| KL drift from baseline > 0.5 nats | — | **TRIGGERED** — MEM 1.32–1.84 nats; fortune 0.78–0.99 nats. All variants exceed the "reconsider" threshold |
| Distinct-2 collapse | — | **PASS, dramatic improvement** on fortune (0.146 → 0.45 = ~3× more diverse) |
| p95 latency > 2× without quality gain | — | **MARGINAL** — MEM ~2.5×; fortune ~18× because the timeout fires. Quality gain present, so not auto-reject |

The MEM ugliness drop to 0 is partly a **measurement artifact**: the
classic generator's ugly flag checks the 3-token emitted chunk for internal
repetition, while PPM's stride-1 ugly flag only looks at A-B-A patterns one
step at a time. The metric isn't directly comparable across stride-1 vs
stride-3. **TODO**: align the ugly detector before relying on this number.

## Qualitative read (seed=1, fortune-haiku)

| prompt | classic | PPM:4 |
|---|---|---|
| hello | as winter melts into spring, so too will your life. through collaboration | the letters of your name speak of wandering paths and adaptability—you are |
| hi daisy | as winter melts into spring, so too will your life. through collaboration | seven paths converge in your near future, each representing a different |
| good morning | you will soon dissolve like morning mist. the path of balance ... | your attention to detail and care for refinement will open doors to unexpected |
| how are you | you will soon find its rightful place, revealing how you perceive them. | a great departure is coming to your path, and what once seemed tangled will |
| what do you like | the threads of steady growth and those who do the same. | a persistent voice will soon challenge your comfort, but do not dismiss |
| computers are fun | as winter melts into spring, so too will your life. through collaboration | your path forward shines with quiet brilliance—trust the gentle guidance |
| tell me about a platypus | as winter melts into spring, so too will your life. through collaboration | a kansan's heart runs deep with the soil of persistence and honest effort. |
| explain photosynthesis | as winter melts into spring, so too will your life. through collaboration | the letters of your name speak of wandering paths and adaptability—you are |

Classic mode emits the same canonical fortune ("as winter melts into spring,
so too will your life. through collaboration") for 12 of the 16 prompts at
seed=1 — that's the deterministic fallthrough artifact noted in
`eval/baseline.md`. PPM:4 still reuses a handful of fortunes (the fallthrough
fallback hasn't changed) but draws from a much wider set, because higher-order
context lets generation actually proceed coherently from many more starting
points before exhausting matches.

## Verdict

**Accept PPM as opt-in (`--generator ppm[:N]`), do not change the default.**

The picture sharpened once the K-gram index made the eval timeout-independent:

1. **Latency is no longer a blocker.** Fortune p50 went from 502 ms (cap)
   to 46 ms with the K-gram index. Both corpora well under chat-comfortable
   latency.
2. **KL drift from baseline is large** (2.1–2.2 nats on fortune; 1.3–1.8
   on MEM) — far above the 0.5-nat "reconsider" threshold. PPM produces
   distinctly different responses than classic.
3. **Diversity is *worse* on fortune** under PPM (distinct-2 0.146 →
   0.080). The previous draft of this report had the opposite finding;
   that was an artifact of the wall-clock cap truncating iteration. With
   the full 1000 attempts, PPM converges on a smaller set of
   high-keyword-overlap winners that the reranker then picks repeatedly.
4. **Character is preserved.** Fallthrough rate held (slight increase on
   fortune); every emitted token still verbatim from the corpus; the
   famous off-topic fallback path is unchanged.
5. **The qualitative read is still better** (see sample table below):
   PPM emits more grammatical, more in-style fortunes than classic, even
   though the *set* of fortunes is smaller. So character-different in two
   ways at once — more fluent per response, less varied across responses.

**Recommended order: 4.** Orders 4 and 5 perform similarly on outputs;
order 3 is closer to classic in style but no clear win. Higher orders
recite more (single sentences as outputs); useful for small corpora
where there's effectively one "voice" to learn.

Why opt-in and not default: PPM trades classic's chaos-with-variety for
"more fluent but more repetitive." That's a different aesthetic, not
strictly better. Worth exposing as a knob.

## Followups

- ~~**Fix the ugly-flag measurement asymmetry.**~~ *(Done — orchestrator-side
  `SuperDaisy::Ugly` runs the same heuristic on every generator's output.
  Metric is now apples-to-apples.)*
- ~~**Add a K-gram index to Corpus.**~~ *(Done — 10× latency improvement on
  the fortune corpus.)*
- ~~**Expose PPM via `bin/daisy --generator`.**~~ *(Done.)*
- **Investigate why fallthrough rate *went up* on fortune** under PPM.
  Probably the same dynamic as the diversity drop — PPM's stronger
  conditional structure produces a narrower output set, so when the
  rejection sampler tries to find keyword-bearing candidates, it sees a
  smaller distribution and exhausts the budget more often. Worth a closer
  look in `eval/ppm4_fortune.json`.
- **Length cap shouldn't auto-mark as ugly on long-sentence corpora.**
  Fortune-style corpora trigger the cap on ~99% of PPM outputs, saturating
  the metric. Consider making the cap a soft penalty (counts toward ugly
  only if combined with cycling), or per-corpus tuning.

## Files

- Data: `eval/ppm{3,4,5}_{mem,fortune}.{md,json}`
- Charts: `eval/ppm_latency_{mem,fortune}.png`,
  `eval/ppm_fallthrough_{mem,fortune}.png`
- Generator: `lib/super_daisy/components/ppm_markov_generator.rb`
- Render: `gnuplot eval/ppm.gp`
