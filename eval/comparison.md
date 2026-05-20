# Super-DAISY component swaps — comparison matrix

Nine configurations × four corpora, 300 trials each. Reference for which
upgrades to keep and which to drop. Reproduce via `./eval/run_all.sh`.

Configs:

| name | generator | scorer | sampler | seed |
|---|---|---|---|---|
| baseline | classic stride-3 | rarest | uniform | uniform |
| +ppm:2 | PPM:2 | rarest | uniform | uniform |
| +ppm:4 | PPM:4 | rarest | uniform | uniform |
| +bm25 | classic | BM25 top-3 | uniform | uniform |
| **+bm25+seed** | classic | BM25 top-3 | uniform | **keyword** |
| **+bm25+seed+ppm:2** | PPM:2 | BM25 top-3 | uniform | **keyword** |
| +bm25 T=0.7 | classic | BM25 top-3 | temperature 0.7 | uniform |
| +bm25 T=0.5 | classic | BM25 top-3 | temperature 0.5 | uniform |
| full | PPM:4 | BM25 top-3 | uniform | uniform |

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

## Results — MEM.DSY (92 sentences, max_length=70)

| metric | baseline | +bm25 | **+bm25+seed** | +bm25+seed+ppm:2 | +ppm:2 | +ppm:4 | full |
|---|---|---|---|---|---|---|---|
| fallthrough rate | 0.767 | 0.267 | **0.267** | 0.267 | 0.767 | 0.767 | 0.267 |
| recitation rate | 0.450 | 0.360 | 0.500 | 0.740 | 0.817 ⚠ | 1.000 ⚠ | 1.000 ⚠ |
| distinct-2 | 0.091 | 0.167 | **0.177** | 0.159 | 0.135 | 0.104 | 0.160 |
| KL drift from baseline | — | 0.553 | **0.538** | 1.404 | 1.820 | 1.329 | 1.056 |
| latency p50 (ms) | 16.4 | 6.2 | **0.7** | 0.9 | 38.4 | 40.5 | 8.8 |

## Results — fortune-haiku (250 sentences, max_length=450)

| metric | baseline | +bm25 | **+bm25+seed** | +bm25+seed+ppm:2 | +ppm:2 | +ppm:4 | full |
|---|---|---|---|---|---|---|---|
| fallthrough rate | 0.807 | 0.270 | **0.280** | 0.273 | 0.803 | 0.803 | 0.270 |
| recitation rate | 0.000 | 0.000 | 0.000 | 0.003 | 0.000 | 0.187 | 0.233 |
| distinct-2 | 0.226 | 0.326 | **0.363** | 0.368 | 0.225 | 0.108 | 0.243 |
| KL drift from baseline | — | 0.429 | **0.387** | 0.683 | 1.318 | 1.541 | 0.883 |
| latency p50 (ms) | 90.5 | 97.1 | **15.9** | 13.2 | 181.5 | 216.2 | 160.3 |

## Results — movie-5k (5000 sentences, max_length=98)

| metric | baseline | +bm25 | **+bm25+seed** | +bm25+seed+ppm:2 | +ppm:2 | +ppm:4 | full |
|---|---|---|---|---|---|---|---|
| fallthrough rate | 0.460 | 0.087 | **0.067** | 0.067 | 0.430 | 0.447 | 0.097 |
| recitation rate | 0.103 | 0.040 | 0.040 | 0.150 | 0.187 | 0.730 ⚠ | 0.673 ⚠ |
| distinct-2 | 0.577 | 0.637 | **0.756** | 0.717 | 0.478 | 0.441 | 0.577 |
| KL drift from baseline | — | 0.340 | **0.350** | 0.422 | 0.718 | 0.725 | 0.478 |
| latency p50 (ms) | 29.9 | 17.2 | **11.3** | 11.6 | 71.6 | 69.6 | 20.4 |

## Results — movie-100k (7937 sentences, max_length=98)

| metric | baseline | +bm25 | **+bm25+seed** | +bm25+seed+ppm:2 | +ppm:2 | +ppm:4 | full |
|---|---|---|---|---|---|---|---|
| fallthrough rate | 0.463 | 0.090 | **0.063** | 0.063 | 0.440 | 0.490 | 0.107 |
| recitation rate | 0.060 | 0.013 | 0.023 | 0.150 | 0.087 | 0.687 ⚠ | 0.633 ⚠ |
| distinct-2 | 0.541 | 0.667 | **0.788** | 0.768 | 0.435 | 0.439 | 0.612 |
| KL drift from baseline | — | 0.348 | **0.382** | 0.428 | 0.824 | 0.797 | 0.495 |
| latency p50 (ms) | 32.5 | 19.1 | **16.0** | 17.9 | 75.7 | 73.4 | 23.1 |

(Temperature variants omitted from these tables — see the "Temperature is a
clean negative result" section. Full data still in `eval/bm25t05_*.json` and
`eval/bm25t07_*.json`.)

## Prompt-aware seeding is the second big win

The keyword-aware seed selector picks the walker's starting sentence from
the pool of sentences that contain a prompt keyword (multiplicity per
keyword hit, so denser sentences are more likely). Walker behavior is
otherwise unchanged. Falls back to uniform random when no keyword
sentences exist.

Effect across corpora, vs `+bm25` (the previous best):

| corpus | bm25 fallthrough | +bm25+seed fallthrough | distinct-2 jump | latency change |
|---|---|---|---|---|
| MEM | 0.267 | 0.267 (corpus-limited) | 0.167 → 0.177 | 6 ms → 0.7 ms |
| fortune | 0.270 | 0.280 | 0.326 → **0.363** | 97 ms → **16 ms (6×)** |
| movie-5k | 0.087 | **0.067** | 0.637 → **0.756** | 17 ms → 11 ms |
| movie-100k | 0.090 | **0.063** | 0.667 → **0.788** | 19 ms → 16 ms |

The latency improvement on fortune is the headline number — when the seed
is already keyword-bearing, the rejection sampler fills its pool in far
fewer attempts (the loop just exits sooner), so total work drops by 6×.
On smaller corpora the absolute speedup is less dramatic but the relative
trend holds.

**Distinct-2 jumps 17-18% on movie corpora** — counterintuitive, but
explained by the multiplicity-weighted seed pool: keyword-bearing
sentences are usually a small subset of the corpus, and the walker
starts from many *different* such sentences across trials, so the walks
land in distinct corpus regions more reliably than uniform-random starts
which often re-seed in the same common-prefix area.

**KL drift stays close to bm25's** (~0.35-0.55 nats across the board),
under the 0.5-nat threshold on 3 of 4 corpora. Style is preserved.

**Qualitative chat sample** on movie-100k — the corpus where the original
incoherence complaint came from:

| config | response to "Who are you?" (seed=42) |
|---|---|
| baseline | _(garbled)_ |
| +bm25 | "what are you could always take these cars don't care how great light has gone crazy. you can't get over it." |
| **+bm25+seed** | "you don't move, you understand?! you know what? it's talkradio. you're on these operations. is my worst fear." |
| **+bm25+seed+ppm:2** | "are you okay?" |

`+bm25+seed+ppm:2` produced an actual conversational reply. The seeded
variants are noticeably more dialogue-shaped on movie corpora.

## Temperature is a clean negative result

Hypothesis going in (per `SUPER_DAISY.md`): low-temperature sampling
would bias the walker toward more common, more coherent continuations.
Trade-off was supposed to be a coherence dial.

What we got: temperature **hurts** on every metric that matters.

| corpus | bm25 fallthrough | +T=0.7 | +T=0.5 |
|---|---|---|---|
| MEM | 0.267 | 0.267 | 0.267 |
| fortune | **0.270** | 0.307 | 0.307 |
| movie-5k | **0.087** | 0.270 ⚠ | 0.273 ⚠ |
| movie-100k | **0.090** | 0.310 ⚠ | 0.330 ⚠ |

| corpus | bm25 latency p50 | +T=0.7 | +T=0.5 |
|---|---|---|---|
| MEM | 4.6 ms | 30 ms | 38 ms |
| fortune | 84 ms | **501 ms** (timeout) | **501 ms** |
| movie-5k | 12 ms | **508 ms** | **508 ms** |
| movie-100k | 17 ms | **516 ms** | **517 ms** |

**Why temperature backfires here.** With low T, the sampler concentrates on
the most-frequent continuation at each branch. That makes generated
sentences converge to a small set of "popular" corpus paths — many
candidates end up near-duplicates. The rejection sampler then *can't find*
keyword-bearing variants, so fallthrough rises and the loop runs all the
way to the wall-clock cap. Latency goes from sub-100ms to 500ms+ (the
hard timeout) on every non-MEM corpus.

Lesson: temperature is the wrong dial for our coherence problem. The
incoherence we observed isn't local-choice noise — it's that our
generator has no awareness of the input prompt and constructs sentences
by random Markov walk regardless. Making each step "more confident"
doesn't fix the lack of prompt conditioning; it just collapses output
diversity.

Verdict: **temperature rejected.** Keep the sampler component pluggable
for future work, but don't add temperature variants to the default config.

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

## PPM:2 is a better PPM than PPM:4 for the movie corpora

Adding PPM:2 to the matrix gave us the missing data point. Recitation
across the PPM family:

| corpus | +ppm:2 recitation | +ppm:4 recitation |
|---|---|---|
| MEM | 0.817 | **1.000** |
| fortune | 0.000 | 0.180 |
| movie-5k | **0.187** | **0.730** |
| movie-100k | **0.087** | 0.687 |

On the movie corpora the difference is striking — order 2 cuts recitation
by 4-8×. PPM:2 keeps the local-fluency benefit (bigram context > unigram)
without collapsing to single-sentence recitation. Distinct-2 is slightly
worse than baseline but not dramatically so.

On MEM the corpus is too small for order 2 to escape recitation either —
the rule "sentence length matters more than corpus size" still holds.

**Updated PPM recommendation:** PPM:2 is the safer default for any
corpus with > a few hundred sentences. PPM:4 stays available for
long-sentence corpora where the recitation risk is naturally low.

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

- **BM25** — accept. Foundation of every good config.
- **Keyword seed selection** — accept. Best stand-alone improvement after
  BM25, and stacks cleanly with it. Lower fallthrough, higher diversity,
  faster, drift comparable to BM25-alone.
- **PPM:2** — viable opt-in. On movie-scale corpora especially, layered
  on top of bm25+seed it produces noticeably more dialogue-shaped
  outputs (per the qualitative chat sample above) at the cost of some
  diversity and a recitation tick-up.
- **PPM:4** — opt-in **only for long-sentence corpora** (fortune-like).
  On short-sentence corpora it recites 69-100% of the time.
- **Temperature** — rejected. Hurts fallthrough, hits the wall-clock cap.
- **full (PPM:4 + BM25)** — same recitation issue as PPM:4 alone.

Suggested defaults going forward:
- **General**: BM25 scorer + keyword seed selector + classic generator.
- **Movie-scale dialogue corpora**: + PPM:2 as the generator on top.

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

Per-corpus, split by family to keep curves legible:

- `comparison_fallthrough_bm25_<corpus>.png` — baseline, +bm25, +bm25 T=0.7, +bm25 T=0.5
- `comparison_fallthrough_ppm_<corpus>.png` — baseline, +ppm:2, +ppm:4, full
- `comparison_latency_bm25_<corpus>.png`
- `comparison_latency_ppm_<corpus>.png`

Generated by `eval/comparison.gp`.
