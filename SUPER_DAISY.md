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

Anything that violates one of those is a different bot wearing her name.

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
- Where on the temperature dial is canonical DAISY? Probably hot — but
  worth measuring on the existing corpus before defining a default.
- For preference learning: do we want explicit user signals during
  conversation, or only on saved transcripts after the fact?
- PPM order: cap at 3? 4? Unbounded with aggressive backoff? Higher orders
  on tiny corpora collapse to "she just recites whole sentences from
  memory" — which might be fine, might not.

## Status

This is exploration, not a plan. Sections to flesh out individually if/when
we pick a direction to actually build.
