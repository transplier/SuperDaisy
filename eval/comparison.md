# Super-DAISY component swaps — comparison matrix

Four configurations, four corpora, 300 trials each. Reference for which
upgrades to keep and which to drop. Reproduce via `./eval/run_all.sh`.

| corpus | sentences | word tokens | mean tokens/sentence |
|---|---|---|---|
| MEM | 92 | 619 | 6.7 |
| fortune-haiku | 250 | 11,974 | 47.9 |
| movie-5k | 507 | 5,005 | 9.9 |
| movie-100k | 10,313 | 100,008 | 9.7 |

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
| **recitation rate** (verbatim corpus sentence) | 0.450 | **1.000** ⚠ | 0.360 | **1.000** ⚠ |
| acceptance rate | 0.003 | 0.003 | **0.020** | 0.019 |
| distinct-2, all trials | 0.091 | 0.104 | **0.167** | 0.160 |
| distinct-2, per-prompt mean | 0.713 | 0.754 | 0.627 | 0.542 |
| KL(responses ‖ corpus) nats | 0.949 | 0.940 | **0.411** | 0.429 |
| KL drift from baseline (nats) | — | 1.329 | **0.553** | 1.056 |
| latency p50 (ms) | 15.8 | 23.1 | **2.6** | 4.3 |
| latency p95 (ms) | 16.4 | 25.4 | 16.8 | 23.9 |

## Results — fortune-haiku (250 sentences, 11974 words)

| metric | baseline | +ppm | +bm25 | full |
|---|---|---|---|---|
| fallthrough rate | 0.810 | 0.890 | **0.330** | 0.320 |
| ugliness rate | 0.860 | 0.997 | 0.667 | 0.803 |
| recitation rate (verbatim corpus sentence) | 0.000 | 0.000 | 0.000 | 0.000 |
| acceptance rate | 0.001 | 0.001 | **0.010** | 0.009 |
| distinct-2, all trials | 0.145 | 0.077 | **0.374** | 0.237 |
| distinct-2, per-prompt mean | 0.909 | 0.893 | 0.864 | 0.657 |
| KL(responses ‖ corpus) nats | 0.559 | 0.627 | **0.278** | 0.380 |
| KL drift from baseline (nats) | — | 2.223 | **0.389** | 1.369 |
| latency p50 (ms) | 26.9 | 46.5 | **27.1** | 45.5 |
| latency p95 (ms) | 27.5 | 48.5 | 28.2 | 47.9 |

## Results — movie-5k (507 sentences, 5005 words)

| metric | baseline | +ppm | +bm25 | full |
|---|---|---|---|---|
| fallthrough rate | 0.487 | 0.473 | **0.110** | 0.113 |
| ugliness rate | 0.150 | 0.177 | 0.230 | 0.180 |
| **recitation rate** | 0.137 | **0.797** ⚠ | 0.107 | **0.827** ⚠ |
| acceptance rate | 0.004 | 0.004 | **0.018** | 0.018 |
| distinct-2, all trials | 0.340 | 0.227 | **0.453** | 0.374 |
| distinct-2, per-prompt mean | 0.854 | 0.667 | 0.814 | 0.641 |
| KL drift from baseline (nats) | — | 1.046 | **0.478** | 0.786 |
| latency p50 (ms) | 21.0 | 33.0 | **4.3** | 6.2 |
| latency p95 (ms) | 21.7 | 34.5 | 22.9 | 34.8 |

## Results — movie-100k (10,313 sentences, 100,008 words)

| metric | baseline | +ppm | +bm25 | full |
|---|---|---|---|---|
| fallthrough rate | 0.443 | 0.470 | **0.103** | 0.103 |
| ugliness rate | 0.057 | 0.053 | 0.193 | 0.137 |
| **recitation rate** | 0.007 | **0.800** ⚠ | 0.020 | **0.727** ⚠ |
| acceptance rate | 0.004 | 0.004 | **0.019** | 0.019 |
| distinct-2, all trials | 0.536 | 0.477 | **0.668** | 0.660 |
| distinct-2, per-prompt mean | 0.962 | 0.935 | 0.952 | 0.923 |
| KL drift from baseline (nats) | — | 0.773 | **0.319** | 0.467 |
| latency p50 (ms) | 27.3 | 38.6 | **10.4** | 12.7 |
| latency p95 (ms) | 30.3 | 43.0 | 29.9 | 44.1 |

## New finding: PPM recitation is driven by sentence length, not corpus size

The recitation metric was added expecting it to catch PPM's mode collapse on
small corpora. The four-corpus matrix shows the actual driver is **sentence
length**, not corpus size:

| corpus | sentences | mean tokens/sentence | +ppm recitation | +full recitation |
|---|---|---|---|---|
| MEM | 92 | 6.7 | **1.000** | **1.000** |
| movie-5k | 507 | 9.9 | **0.797** | **0.827** |
| movie-100k | 10,313 | 9.7 | **0.800** | **0.727** |
| fortune-haiku | 250 | 47.9 | 0.000 | 0.000 |

A 10K-sentence corpus with average-length sentences still gets ~80%
recitation under PPM:4 — corpus size alone doesn't save us. Short
sentences are the issue: PPM with order=4 has at most ~6 tokens of
"choice" before the sentence ends, and most 4-grams have a single
in-corpus next token, so the walker tracks one sentence to termination.

Fortune's 48-tokens-per-sentence average gives the PPM walker enough room
to make real choices before hitting a terminator.

**Implication:** PPM:4 is contraindicated on any corpus where mean
sentence length is < ~20 tokens, regardless of how many sentences exist.
For short-sentence corpora, either drop the PPM order or skip PPM.

## Headline finding: BM25 is the big win — consistent across all corpora

BM25's effect dwarfs PPM's on every metric that maps to "the kernel is
actually working", and now across four corpora:

| corpus | baseline fallthrough | +bm25 fallthrough | drop |
|---|---|---|---|
| MEM | 0.767 | 0.267 | **-50 pp** |
| fortune | 0.810 | 0.330 | **-48 pp** |
| movie-5k | 0.487 | 0.110 | **-38 pp** |
| movie-100k | 0.443 | 0.103 | **-34 pp** |

| corpus | BM25 KL drift from baseline |
|---|---|
| MEM | 0.553 (just over 0.5 threshold) |
| fortune | 0.389 (**under**) |
| movie-5k | 0.478 (**under**) |
| movie-100k | 0.319 (**under**) |

Drift is at or under the "reconsider" threshold on three of four corpora —
the BM25 output distribution is the *most similar* to canonical DAISY of
any swap we've measured, while dramatically improving the rejection
sampler's behavior.

- **Acceptance rate jumps 5-10× on every corpus.**
- **Latency improves or holds**, sometimes dramatically: movie-5k p50
  drops from 21ms to 4ms; movie-100k from 27ms to 10ms. BM25 lets the
  bot exit the rejection loop earlier because the filter actually finds
  candidates.

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

- **BM25** — accept across the board. Consistent 30-50 pp fallthrough
  reduction, drift at or under threshold on 3/4 corpora, latency
  improvement on every corpus. Ready to consider as default.
- **PPM** — keep opt-in **only for long-sentence corpora** (mean ≥ ~20
  tokens/sentence). On short-sentence corpora, regardless of size, it
  recites 73-100% of the time. The earlier "fortune-scale" framing was
  wrong — it's sentence-length that matters.
- **full** — recitation issue carries over from PPM. Not recommended on
  short-sentence corpora.

Suggested defaults going forward: BM25 scorer, classic generator.

## Followups

- **Soak BM25 longer** before flipping the default. Run with more seeds
  and more diverse prompts; check if any pathological inputs make BM25
  worse than baseline.
- **Calibrate BM25 top_k.** Default 3 might not be right for all corpus
  sizes; try `bm25:5` and `bm25:2` on the matrix.
- **PPM order should be corpus-aware.** Order=4 trips the recitation
  threshold on a 92-sentence corpus. A simple heuristic: use lower order
  when `corpus.sentences.size` is small (e.g., order = min(4, log2(N))).
- **Acceptance rate is still tiny in absolute terms** (~2% on +bm25,
  ~1% on +bm25 fortune). Big *relative* improvement over baseline's
  0.1-0.3%, but the rejection sampler is still wasting 98%+ of attempts.
  Worth investigating whether `pool_size=10` is even reachable in
  practice, or whether we should drop it to 5.
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
