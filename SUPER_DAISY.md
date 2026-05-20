# Super-DAISY

A working doc for exploring where modern LM design ideas intersect with DAISY's
architecture, without erasing what makes her DAISY.

## The kernel we want to preserve

- **She can only say what she's seen.** No learned weights, no generation
  beyond her corpus. Outputs are traces of memorized text.
- **Learning is corpus append.** No gradient descent, no fine-tune step.
  A turn is observed, tokens are appended.
- **Generation is a walk through her memory**, not a forward pass.
- **Her famous incoherence is a feature**, not a bug. The keyword filter
  often fails and she falls through to unconditioned Markov — those
  non-sequiturs are her signature.

Anything that violates one of those is a different bot wearing her name. Preserving compatibility with .DSY "personality files" is a goal, although not a hard constraint (particularly if we can "upgrade" older files).

## Pipeline stage walkthrough

DAISY's pipeline maps closely onto the shape of a modern LM stack — every
component just happens to be one line of Pascal. Going stage by stage:

### Stage 1 — Tokenizer

- **Current:** whitespace + lowercase.
- **Modern:** BPE / WordPiece.
- **Tradeoff:** subwords would unify `platypus` and `platypus.` (currently
  distinct tokens) and share statistics across morphology. Mild character
  drift — subtly more fluent, but she'd start emitting morphologically
  plausible non-words on rare backoffs. Probably not worth it unless paired
  with a generator upgrade.

### Stage 2 — "Importance" of input tokens

- **Current:** rarest-input-word wins. Degenerate IDF: no TF, no length norm,
  arbitrary tiebreaking.
- **Modern:** BM25.
- **Tradeoff:** straight drop-in. Same intuition (rare matches > common
  matches), better behaved. Preserves her literal-keyword philosophy.
  **Probably the cheapest research-flavored win.**

### Stage 3 — Generator

- **Current:** 1st-order Markov with stride-3 emission, no smoothing.
- **Honest historical successor:** **PPM (Prediction by Partial Matching)**
  or variable-order Markov with **Kneser-Ney backoff**. Walker uses a 4-gram
  context when seen, backs off to 3-gram → 2-gram → unigram. Same corpus,
  same "she can only say what she's seen" invariant. Genuinely state-of-the-art
  for text compression in the 90s.
- **Modern neural alternative:** tiny transformer or RNN trained on the corpus.
- **Tradeoff:** the neural option is the obvious modern move and exactly the
  wrong one — it untethers outputs from corpus traces and erases her honesty.
  PPM is the right answer: raises her IQ without a brain transplant.

### Stage 4 — Candidate filtering

- **Current:** hard keyword-presence filter, then rerank by overlap count.
- **Modern:** constrained decoding (trie-guided, FUDGE, logit biasing).
- **Tradeoff:** biasing the sampler itself is character-altering — it removes
  the "she often misses and emits non-sequiturs" failure mode. **Middle
  ground:** logit-bias the *rerank*, not the sampler. Score candidates by a
  combination of keyword overlap, perplexity under her own corpus stats,
  length, etc. Pure post-hoc reranking on Markov samples. Soul intact.

### Stage 5 — Rerank

- **Current:** overlap-count score (one-line reward model).
- **Modern:** learned preference reranker. After each turn, user signals
  "more of that" / "less" → train a tiny linear or shallow-MLP reward over
  hand-coded features (overlap, length, n-gram likelihood, novelty vs. last
  turn). RLHF without the RL — direct preference optimization on a 5-feature
  reward.
- **Tradeoff:** faithful — she still generates from her corpus, just gets
  better at picking. Optional.

### Stage 6 — Online learning & memory

- **Current:** append input to corpus. `LastSubs` carries last turn's keywords.
- **Modern:**
  - **RAG.** Embed her sentences (PPMI + SVD over co-occurrence gets you
    something like GloVe with no neural net), retrieve the K most
    semantically related sentences to the current input, use them to seed
    the Markov walker.
  - **In-context window.** Widen `LastSubs` from 1-turn to K-turn rolling
    window with exponential decay.
- **Tradeoff:** both preserve "she only says what she's seen" while adding
  topical coherence and short-term memory. RAG over her own corpus is the
  highest-leverage idea here — she's *already* a retrieval system, just with
  terrible retrieval (uniform sentence sampling).

### Stage 7 — Sampling

- **Current:** uniform over occurrences.
- **Modern:** temperature / top-p (weight Markov branches by frequency raised
  to some power).
- **Tradeoff:** one-line change, gives a coherence dial — turn it up for
  chaotic-original-DAISY, down for boringly-coherent-DAISY. Same data, same
  walker. **The cleanest "modern decoding" idea that maps perfectly onto her
  existing sampler.**

## Proposed tech tree

Ordered by character-preserved-to-fluency-gained ratio:

1. **PPM / variable-order Markov with backoff** — biggest fluency jump,
   kernel fully intact, historically appropriate.
2. **Temperature / top-p sampling knob** — trivial, coherence dial.
3. **BM25 reranker** — sharper keyword scoring, drop-in.
4. **K-turn keyword window** — proper short-term conversation memory.
5. **PPMI + SVD embeddings → retrieve-then-walk** — semantic conditioning
   without leaving her corpus.
6. **Preference-learned reward for reranking** — RLHF-lite, optional.

## What we'd avoid

- Any **learned generator** (transformer, RNN, neural LM head). That's not
  Super-DAISY, that's a different bot wearing her name.
- Any **constrained or guided decoding that operates on the sampler itself**
  (vs. on rerank). Erases the off-topic non-sequiturs, which are arguably
  the whole point.

## Lineage note

Items 1 + 3 + 4 + 7 together land on something that looks remarkably like a
**circa-2010 dialogue system** (PPM + BM25 + windowed retrieval) — her
natural evolutionary trajectory if she'd kept getting maintained from 2000
onward, instead of jumping straight to LLMs.

## Open questions for us

- Is "she can only say what she's seen" really the kernel, or is it
  specifically "she only says what *some human* has said to her"? Affects
  whether RAG over external corpora (Wikipedia, books) is in-character.
  Gia: Part of Daisy's charm is that her entire existence is "in a bottle" - that being, a plaintext .DSY file. So, no RAG or the like.
- Where on the temperature dial is canonical DAISY? Probably hot — but
  worth measuring on the existing corpus before defining a default.
- For preference learning: do we want explicit user signals during
  conversation, or only on saved transcripts after the fact?
- PPM order: cap at 3? 4? Unbounded with aggressive backoff? Higher orders
  on tiny corpora collapse to "she just recites whole sentences from
  memory" — which might be fine, might not.

## Prompt-awareness experiments

DAISY's generator and sampler are completely prompt-blind. Every generated
sentence is a uniformly-random Markov walk through the corpus; the prompt
only influences which of those walks gets *kept* (via the keyword filter
and reranker). That structural blindness is the deep source of the
"in-character but locally incoherent" responses she's known for. Whether
it can be partially mitigated without erasing her voice is an open
question worth investigating in small increments.

We've graded character impact on the scale from "kernel intact" (verbatim
corpus, walker mechanics unchanged) to "guided decoding" (walker becomes
goal-directed). Options 2-4 below remain unattempted and are kept here
as candidates for future evaluation rounds.

### Option 1 — prompt-aware seed selection [DONE — accepted]

Bias the walker's starting sentence toward sentences that contain a
prompt keyword. Walker behavior is otherwise unchanged.

Implemented as `KeywordSeedSelector`. See `eval/comparison.md`. Results:
fallthrough drops further on every corpus, distinct-2 jumps 17-18% on
movie corpora, latency improves dramatically (6× on fortune), KL drift
stays under threshold. Qualitative chat outputs become noticeably more
dialogue-shaped. Recommended default.

### Option 2 — bidirectional walk from keyword anchor [TODO]

Find a position in the corpus where a keyword token literally appears.
Walk *backward* from that position for a few tokens (to a sentence-start
neighborhood, stopping at SENTINEL), then walk forward normally. Every
output contains the keyword by construction.

- **Kernel impact:** intact. Backward walk through the corpus is no more
  generative than forward walk.
- **Voice impact:** moderate. Walker becomes anchored at the keyword.
  Outputs will reliably contain the keyword (current bm25+seed only
  *biases* toward it). Recitation likely rises — the path through and
  around a specific keyword position is fairly constrained.
- **Expected effect:** fallthrough rate near zero on any corpus that
  contains the keyword at all. Big distinct-N drop (similar to PPM's
  effect — outputs concentrate on a small set of keyword-neighborhoods).
- **Why it's worth trying anyway:** for short-sentence corpora where
  bm25+seed still has high fallthrough (because the keyword sentence
  pool is small), this guarantees keyword presence. The off-topic
  chaos at the *non-keyword* parts of the sentence is preserved.
- **Component shape:** new `KeywordAnchoredGenerator`. Walker direction
  is internal; orchestrator passes keywords and a corpus position.

### Option 3 — goal-biased branch selection during walk [TODO, risky]

At each Markov branch point, if any next-token would lead toward a corpus
path containing a remaining keyword, prefer it. Look-ahead beam-search
style.

- **Kernel impact:** intact (still verbatim corpus tokens).
- **Voice impact:** large. Walker becomes goal-directed. Loses the
  "wanders into a non-sequitur" property which is core to her charm.
- **This is the "guided decoding on the sampler" we explicitly ruled
  out** in the original write-up. Documenting it here as a known
  branch, not as a recommendation. If we ever want a "less DAISY,
  more chatbot" mode, this is one option.
- **Expected effect:** very low fallthrough, very low distinct-N,
  near-recitation outputs that all contain the keyword.

### Option 4 — keyword-density reranker [DONE — accepted as opt-in]

Modify the reranker to score by `overlap / response_length` instead of
raw overlap count.

Implemented as `DensityReranker`. Results: roughly halves mean response
length across all corpora. Distinct-2 takes a small hit on movie corpora
(-0.02 to -0.07) and a small bump on fortune (+0.04). Recitation ticks
up modestly when stacked with PPM:2 on movie corpora (0.15 → 0.32-0.35).
KL drift stays under threshold on 3 of 4 corpora.

Qualitatively, density+PPM:2 produces the most dialogue-shaped outputs
of any config measured ("are you okay?" / "so, do you mean?" / "maybe
he doesn't know it." on movie-100k). Effectively a *length knob* more
than a quality knob — shorter outputs feel more chat-like.

Recommended as opt-in for chat/dialogue use; not enabled by default.

## Status

The "honest" tech tree from earlier in this document is partially
implemented:

- ~~PPM / variable-order Markov with backoff~~ (done, opt-in)
- Temperature / top-p sampling knob (done, *rejected* — see eval)
- ~~BM25 reranker~~ (done as BM25 scorer — accepted as default)
- K-turn keyword window (not yet)
- PPMI + SVD embeddings → retrieve-then-walk (ruled out by Gia's
  "in-a-bottle" preference)
- Preference-learned reward for reranking (not yet)

Plus a few items that emerged during evaluation:
- ~~auto max_length from corpus~~ (done, accepted)
- ~~prompt-aware seed selection (Option 1)~~ (done, accepted)
- ~~keyword-density reranker (Option 4)~~ (done, accepted as opt-in)
- Options 2-3 above (not yet)
- K-turn memory swap (the current LastTurnMemory is the minimal version)
