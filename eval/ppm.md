# PPM generator — evaluation

First real Super-DAISY component swap: replacing the classic stride-3
1st-order Markov walker (`StrideThreeMarkovGenerator`) with a variable-order
PPM-style walker with backoff (`PpmMarkovGenerator`). All other components
unchanged. Evaluated against `eval/baseline.md`.

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
| ugliness rate | 0.087 | 0.000 | 0.000 | 0.000 |
| mean length (tokens) | 8.0 | 8.5 | 8.6 | 8.6 |
| distinct-2 | 0.091 | 0.090 | 0.107 | 0.106 |
| distinct-3 | 0.120 | 0.097 | 0.116 | 0.116 |
| KL(responses ‖ corpus) nats | 0.951 | 0.873 | 0.932 | 0.849 |
| **KL drift from baseline (nats)** | — | **1.632** | **1.321** | **1.842** |
| latency p50 (ms) | 16.0 | 37.5 | 40.4 | 42.5 |
| latency p95 (ms) | 16.7 | 39.3 | 42.4 | 44.5 |
| mean attempts | 858 | 858 | 859 | 859 |
| mean kept | 2.26 | 2.24 | 2.23 | 2.23 |

## Results — fortune-haiku (250 sentences, 11974 words)

| metric | classic | PPM:3 | PPM:4 | PPM:5 |
|---|---|---|---|---|
| fallthrough rate | 0.810 | 0.873 | 0.900 | 0.907 |
| ugliness rate | 0.840 | 0.900 | 0.983 | 0.963 |
| mean length (tokens) | 12.2 | 12.2 | 12.4 | 12.4 |
| distinct-2 | 0.146 | **0.456** | 0.388 | 0.334 |
| distinct-3 | 0.169 | **0.528** | 0.455 | 0.380 |
| KL(responses ‖ corpus) nats | 0.558 | **0.197** | 0.211 | 0.238 |
| **KL drift from baseline (nats)** | — | **0.776** | **0.869** | **0.985** |
| latency p50 (ms) | 27.3 | 501.6 | 501.8 | 502.0 |
| latency p95 (ms) | 28.0 | 502.1 | 502.4 | 502.6 |
| mean attempts | 966 | 832 | 687 | 592 |
| mean kept | 0.83 | 0.61 | 0.58 | 0.55 |

(`Bot#timeout` defaults to 0.5 s — PPM hits the wall-clock cap on fortune
*every call*. The flat ~502 ms is the cap, not the cost of work.)

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

**Accept PPM as an opt-in alternative, do not change the default yet.**

Reasoning:

1. **KL drift exceeds the "reconsider" threshold but in the right direction.**
   KL(responses ‖ corpus) actually *drops* under PPM (0.558 → ~0.2 on
   fortune) — outputs are statistically closer to the corpus's own style.
   The drift from baseline measures change-from-classic, not deterioration.
2. **Diversity dramatically improves** on the corpus where classic was
   visibly broken. 3× distinct-2 on fortune is a real qualitative win.
3. **Character is intact.** Fallthrough rate is preserved or higher, kernel
   invariants hold (every token from corpus, no smoothing), the famous
   off-topic fallback is unchanged.
4. **Latency is a real concern on big corpora.** PPM hits the wall-clock
   cap on every fortune call. Acceptable for chat (still <1s) but the cap is
   doing all the work; raise the cap or add a K-gram index before promoting
   to default.
5. **The MEM corpus has too much fallthrough for any generator change to
   help much.** Both classic and PPM are dominated by the deterministic
   fallback path. PPM's improvements show up when the rejection sampler
   actually succeeds, which on MEM is rare (~23% of trials).

**Recommended order: 4.** Order 3 is too close to classic; order 5 starts
recitation-collapsing (5-gram contexts have very few matches in either
corpus, so it backs off to lower order most of the time anyway and the
extra cost is unjustified).

## Followups

- **Fix the ugly-flag measurement asymmetry.** Either port the
  3-token-chunk cycle check to PPM's stride-1 form, or rewrite the classic
  generator's check to be stride-1-equivalent. Currently the metric is
  apples-to-oranges across generators.
- **Add a K-gram index to Corpus** (`Hash<[t1..tK], Array<Int>>`,
  lazy-built per K, invalidated on `learn()`) so PPM doesn't pay the
  positions_of-then-verify cost per step. Should drop fortune latency
  from 500 ms to tens of ms.
- **Investigate why fallthrough rate *went up* on fortune** under PPM. My
  guess: PPM produces longer coherent runs, more often hitting the
  `max_length` cap before a terminator bigram, returning ugly candidates
  that the orchestrator's filter then... wait, the filter doesn't look at
  ugliness; that's the reranker's tiebreaker. So this needs proper
  investigation. Stats already exist in `eval/ppm4_fortune.json`.
- **Expose PPM via `bin/daisy --generator`** once latency is addressed.

## Files

- Data: `eval/ppm{3,4,5}_{mem,fortune}.{md,json}`
- Charts: `eval/ppm_latency_{mem,fortune}.png`,
  `eval/ppm_fallthrough_{mem,fortune}.png`
- Generator: `lib/super_daisy/components/ppm_markov_generator.rb`
- Render: `gnuplot eval/ppm.gp`
