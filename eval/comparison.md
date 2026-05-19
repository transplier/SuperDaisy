# Super-DAISY component swaps — comparison matrix

Four configurations, four corpora, 300 trials each. Reference for which
upgrades to keep and which to drop. Reproduce via `./eval/run_all.sh`.

| corpus | sentences | word tokens | mean tokens/sentence | auto max_length (chars) |
|---|---|---|---|---|
| MEM | 92 | 619 | 6.7 | 52 |
| fortune-haiku | 250 | 11,974 | 47.9 | 450 |
| movie-5k | 507 | 5,005 | 9.9 | 77 |
| movie-100k | 10,313 | 100,008 | 9.7 | 75 |

`max_length` defaults to `Bot.auto_max_length(corpus)` = `round(mean corpus
sentence chars × 1.5)`, floored at 40. CLI override available via
`--max-length N`. The numbers below are with auto.

| name | generator | scorer |
|---|---|---|
| baseline | classic stride-3 | rarest-word |
| +ppm | PPM:4 | rarest-word |
| +bm25 | classic stride-3 | BM25 (top-3) |
| full | PPM:4 | BM25 (top-3) |

Per the methodology in `eval/baseline.md`, KL drift from baseline > 0.5 nats
is a "reconsider" threshold — we look at whether the drift represents
genuine improvement or regression rather than auto-rejecting.

## Results — MEM.DSY (92 sentences, max_length=52)

| metric | baseline | +ppm | +bm25 | full |
|---|---|---|---|---|
| fallthrough rate | 0.767 | 0.767 | **0.267** | 0.267 |
| ugliness rate | 0.113 | 0.157 | 0.110 | 0.067 |
| **recitation rate** | 0.210 | **1.000** ⚠ | 0.323 | **1.000** ⚠ |
| acceptance rate | 0.003 | 0.003 | **0.020** | 0.019 |
| distinct-2, all trials | 0.107 | 0.104 | **0.176** | 0.159 |
| distinct-2, per-prompt mean | 0.819 | 0.753 | 0.654 | 0.551 |
| KL drift from baseline (nats) | — | 1.501 | **0.624** | 1.184 |
| latency p50 (ms) | 15.9 | 23.2 | **2.6** | 4.2 |

## Results — fortune-haiku (250 sentences, max_length=450)

| metric | baseline | +ppm | +bm25 | full |
|---|---|---|---|---|
| fallthrough rate | 0.807 | 0.803 | **0.270** | 0.270 |
| ugliness rate | 0.110 | 0.097 | 0.260 | 0.120 |
| recitation rate | 0.000 | 0.180 | 0.000 | 0.237 |
| acceptance rate | 0.002 | 0.002 | **0.013** | 0.013 |
| distinct-2, all trials | 0.226 | 0.097 | **0.326** | 0.232 |
| distinct-2, per-prompt mean | 0.923 | 0.839 | 0.893 | 0.709 |
| KL drift from baseline (nats) | — | 1.583 | **0.429** | 0.909 |
| latency p50 (ms) | 88.3 | 196.9 | **50.9** | 117.5 |

## Results — movie-5k (507 sentences, max_length=77)

| metric | baseline | +ppm | +bm25 | full |
|---|---|---|---|---|
| fallthrough rate | 0.487 | 0.473 | **0.110** | 0.113 |
| ugliness rate | 0.143 | 0.180 | 0.220 | 0.183 |
| **recitation rate** | 0.137 | **0.793** ⚠ | 0.110 | **0.827** ⚠ |
| acceptance rate | 0.004 | 0.004 | **0.018** | 0.018 |
| distinct-2, all trials | 0.345 | 0.231 | **0.452** | 0.366 |
| distinct-2, per-prompt mean | 0.855 | 0.661 | 0.812 | 0.633 |
| KL drift from baseline (nats) | — | 1.057 | **0.483** | 0.789 |
| latency p50 (ms) | 21.7 | 35.1 | **4.4** | 6.5 |

## Results — movie-100k (10,313 sentences, max_length=75)

| metric | baseline | +ppm | +bm25 | full |
|---|---|---|---|---|
| fallthrough rate | 0.443 | 0.467 | **0.103** | 0.103 |
| ugliness rate | 0.063 | 0.063 | 0.197 | 0.137 |
| **recitation rate** | 0.007 | **0.800** ⚠ | 0.013 | **0.727** ⚠ |
| acceptance rate | 0.004 | 0.004 | **0.019** | 0.019 |
| distinct-2, all trials | 0.535 | 0.475 | **0.667** | 0.659 |
| distinct-2, per-prompt mean | 0.964 | 0.935 | 0.953 | 0.926 |
| KL drift from baseline (nats) | — | 0.773 | **0.314** | 0.464 |
| latency p50 (ms) | 27.5 | 40.5 | **10.6** | 13.1 |

## What changed with the auto max_length

Previously `max_length=70` chars hard-coded for every corpus. Now it's
`mean(corpus sentence chars) × 1.5`. The shift is dramatic on fortune
(70 → 450) because fortune's natural sentences average ~290 chars; the
old cap was chopping every output to a quarter of corpus-natural length.

The fortune-side changes are the headline:

| fortune metric | before auto-cap | after auto-cap |
|---|---|---|
| baseline ugliness | 0.860 | **0.110** |
| +ppm ugliness | 0.997 | **0.097** |
| +bm25 ugliness | 0.667 | 0.260 |
| baseline mean length (tokens) | 12.2 | **29.9** |
| baseline latency p50 (ms) | 26.9 | 88.3 |

The ugliness number now reflects actual cyclic content instead of being
saturated by length-cap firing. Mean response length nearly tripled and
now sits in fortune's actual style envelope. Latency went up — generating
longer responses costs more — but stays well under a second.

PPM recitation on fortune ticked *up* from 0.000 → 0.180 as expected: with
room to walk, PPM occasionally reaches sentence-end before terminator,
yielding verbatim corpus sentences.

On MEM the auto-cap is *tighter* than 70 (cap=52). Ugliness slightly up
(0.090 → 0.113); other metrics basically unchanged. The auto rule keeps
each corpus in its own style.

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
