# Super-DAISY component swaps — comparison matrix

Four configurations, two corpora, 300 trials each. Reference for which
upgrades to keep and which to drop. Reproduce via `./eval/run_all.sh`.

| name | generator | scorer |
|---|---|---|
| baseline | classic stride-3 | rarest-word |
| +ppm | PPM:4 | rarest-word |
| +bm25 | classic stride-3 | BM25 (top-3) |
| full | PPM:4 | BM25 (top-3) |

Per the methodology in `eval/baseline.md`, KL drift from baseline > 0.5 nats
is a "reconsider" threshold — we look at whether the drift represents
genuine improvement or regression rather than auto-rejecting.

## Results — MEM.DSY (92 sentences, 619 words)

| metric | baseline | +ppm | +bm25 | full |
|---|---|---|---|---|
| fallthrough rate | 0.767 | 0.767 | **0.267** | 0.267 |
| ugliness rate | 0.090 | 0.000 | 0.077 | 0.000 |
| distinct-2 | 0.091 | 0.104 | **0.167** | 0.160 |
| distinct-3 | 0.119 | 0.113 | **0.237** | 0.173 |
| KL(responses ‖ corpus) nats | 0.949 | 0.940 | **0.411** | 0.429 |
| KL drift from baseline (nats) | — | 1.329 | **0.553** | 1.056 |
| latency p50 (ms) | 15.8 | 23.1 | **2.6** | 4.3 |
| latency p95 (ms) | 16.4 | 25.4 | 16.8 | 23.9 |
| mean attempts | 858 | 859 | **369** | 385 |
| mean kept candidates | 2.26 | 2.23 | **7.33** | 7.33 |

## Results — fortune-haiku (250 sentences, 11974 words)

| metric | baseline | +ppm | +bm25 | full |
|---|---|---|---|---|
| fallthrough rate | 0.810 | 0.890 | **0.330** | 0.320 |
| ugliness rate | 0.860 | 0.997 | 0.667 | 0.803 |
| distinct-2 | 0.145 | 0.077 | **0.374** | 0.237 |
| distinct-3 | 0.166 | 0.080 | **0.461** | 0.264 |
| KL(responses ‖ corpus) nats | 0.559 | 0.627 | **0.278** | 0.380 |
| KL drift from baseline (nats) | — | 2.223 | **0.389** | 1.369 |
| latency p50 (ms) | 26.9 | 46.5 | **27.1** | 45.5 |
| latency p95 (ms) | 27.5 | 48.5 | 28.2 | 47.9 |
| mean attempts | 966 | 966 | **602** | 600 |
| mean kept candidates | 0.83 | 0.66 | **5.79** | 5.63 |

## Headline finding: BM25 is the big win

BM25's effect dwarfs PPM's on every metric that maps to "the kernel is
actually working":

- **Fallthrough rate drops by ~50 pp on both corpora** (0.77 → 0.27,
  0.81 → 0.33). This is the metric the baseline report flagged as most
  important. For the first time, the rejection sampler is *finding*
  keyword-bearing candidates more often than it gives up.
- **Mean kept candidates jumps 3-7×** (2.3 → 7.3 on MEM; 0.8 → 5.8 on
  fortune). The pool fills.
- **Distinct-2 nearly doubles on MEM**, and more than doubles on fortune
  (0.145 → 0.374) — a huge diversity gain.
- **KL drift from baseline is the smallest of any swap we've tested**
  (0.55 nats on MEM, 0.39 on fortune — *under* the threshold on fortune).
  The output distribution is statistically the *most similar* to canonical
  DAISY of any variant, while behaving better.
- **Latency improves or holds.** BM25 doesn't slow generation, and on MEM
  the bot actually exits the rejection loop earlier (mean attempts 858 →
  369) because the keyword filter finds enough candidates faster.

The mechanism: top-3 IDF keywords are more inclusive than rarest-tied,
which always picked unseen-in-corpus tokens (frequency 0 trivially wins
"rarest"). Unseen keywords can never match any candidate, forcing the
fallthrough path. BM25 ignores zero-frequency tokens (they get IDF
weighting but are deprioritized when there are seen tokens around) and
returns multiple alternatives, so the filter has real targets.

## Qualitative — fortune, seed=1 first 12 prompts

Baseline produces the canonical fallthrough sentence "as winter melts into
spring, so too will your life. through collaboration" for **8 of 12**
prompts. +ppm doubles down on the same failure mode — "your path leads
toward comfort and abundance" for 9 of 12. +bm25 produces **a different
response for every prompt**, and the responses look topically plausible
(e.g., "good morning" → "a moment of appreciation. good fortune favors
those who live boldly..."). full is a mix between BM25's diversity and
PPM's repetitive winners.

## PPM revisited

The earlier reading on PPM (`eval/ppm.md`) still holds: PPM is more
fluent per-response but narrows the output set. The four-config matrix
makes this sharper:

- PPM in isolation is the worst diversity result (distinct-2 0.077 on
  fortune, half of baseline).
- PPM contributes to **full** by making the small set of winners more
  fluent — but at the cost of cutting distinct-2 back to 0.237 from
  BM25's 0.374.

PPM is doing something real but it's an aesthetic trade-off, not an
unambiguous upgrade.

## Verdict

- **BM25** — clear accept. Lowest drift, biggest character-preserving
  impact, no latency cost. Worth promoting to default eventually after
  more soak.
- **PPM** — keep as opt-in. The narrative is "more fluent per
  response, less variety across responses" — a defensible aesthetic but
  not a default-worthy upgrade.
- **full** — interesting but the BM25 wins erode under PPM. Keep
  available; don't recommend as default.

Suggested defaults going forward: BM25 scorer, classic generator.

## Followups

- **Soak BM25 longer** before flipping the default. Run with more seeds
  and more diverse prompts; check if any pathological inputs make BM25
  worse than baseline.
- **Calibrate BM25 top_k.** Default 3 might not be right for all corpus
  sizes; try `bm25:5` and `bm25:2` on the matrix.
- **Investigate the +full interaction.** Why does PPM erode BM25's
  diversity gains? Probably the same reranker-winner-concentration
  dynamic we saw in PPM-alone, but now applied to BM25's richer
  candidate pool.
- **Fortune fallthrough still ~33%.** Better than 81% but not zero —
  what corpus-side dynamics keep this high?

## Charts

- `comparison_latency_{mem,fortune}.png` — sorted-latency CDFs.
- `comparison_fallthrough_{mem,fortune}.png` — per-prompt fallthrough
  rates across the four configs.

Generated by `eval/comparison.gp`.
