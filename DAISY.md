# DAISY v1.1 — Technical Report

**Source:** Greg Leedberg, 2000–2005. ~2400-line single-program Free Pascal for DOS (`source/daisy.pas`), plus an init utility, a UDLP2 link shell, and a "typing animator" (`WRITER.EXE`). Persistent state lives in `.DSY` memory files; ephemeral state in `buffer.bfb` and `term.bfb`.

The marketing pitch is "no hard-coded language — she learns from what you type." Stripped to its ML content, DAISY is a **non-parametric, unigram-context Markov text generator** with **rejection-sampling against an IDF-style keyword filter**, online-updated by simple corpus append.

## 1. Representation

The entire knowledge base is a single in-memory **singly-linked list of word tokens** (`Memory : WordPtr`, `UWord.UserWord : string[15]`). Sentences are delimited by a sentinel token `'***'`. There is no vocabulary table, no count matrix, no probability table — token frequencies are implicit in repeated list occurrences. Lookups are O(N) linear scans.

Persistence is a plaintext `.DSY` file: header (`DaisyName`, `LearnMode 0/1`) followed by one token per line. The shipped `MEM.DSY` is ~4 KB / ~255 words.

## 2. Learning

`Learn(First)` (`daisy.pas:1519`) simply walks to the tail of `Memory` and appends every token the user just typed, followed by `'***'`. That is the entire training step:

- No counts updated, no smoothing, no probability estimation.
- "Frequency" emerges because frequent n-grams appear more often in the list and are therefore more likely to be hit by the uniform random scans below.
- `parse()` tokenizes on whitespace, lowercases, and substitutes the user's own name with `#3 + DaisyName` so first/second-person referents swap on echo (a hand-built reflection trick mirrored in `Okay()` on output).
- `Clean()` strips `;!()/\:",.?` for comparisons but punctuation is preserved on tokens — that's how sentence-final words can later be recognized as terminators.

## 3. Generation: `Response` (`daisy.pas:707`)

The base sentence sampler:

1. Count `'***'` sentinels → number of sentences `sentCount`.
2. Pick a uniform-random sentence index, walk to it, emit its first three tokens (`Word1 Word2 Word3`).
3. Repeatedly call `ReturnPattern(LastWord, …)` (`daisy.pas:567`): scan `Memory` for every occurrence of `LastWord`, pick one uniformly at random, return the next three tokens. Append.
4. Stop when (a) the bigram/trigram `Word2 Word3` appears in `term.bfb` (precomputed list of last-2- and last-3-word tails of every memorized sentence — a **data-driven termination dictionary** rather than fixed punctuation), or (b) Word3 ran off the end.

This is effectively a **1st-order Markov chain with stride-3 emission**: conditioning context is a single token, but each transition pastes a three-token block from the corpus, so local trigram fluency is preserved while branching only happens on single-word collisions. Sampling is proportional to empirical occurrence (uniform over hits).

Anti-degeneracy heuristics, all crude:

- A `#14` sentinel char is prepended to a candidate when an immediate local cycle is detected (`Word1=VoidWord` or `Word2=LastWord` or `Word3=Word1`).
- Same flag added if final length > 70 chars ("attempt to curb the very stupid run-on sentences", `daisy.pas:1775`).

## 4. Response selection: `BestResponse` (`daisy.pas:1630`)

This is the most "ML-shaped" part:

**Keyword extraction.** For each token in the user input, compute `Percent(word) = 100 · count(word in memory) / total_tokens` (`daisy.pas:1449`). Take the **minimum** percentage across the input — this is the rarest input word relative to corpus frequency — and keep all input tokens tied at that minimum as `KeyWord`. Functionally this is a one-shot **inverse-document-frequency surrogate**: the rarer a word the user said, the more "important" it's deemed (matching the manual's claim of "weeding out the unimportant words").

**Conversation memory.** `LastSubs` retains the previous turn's keywords; when `Connect=TRUE`, they are prepended to this turn's keyword set — a primitive topical-continuity carryover.

**Candidate generation + rejection sampling.** A pool of up to `PossibleMax = 10` candidate sentences is drawn either from a precomputed `buffer.bfb` of `BufferSize` (default 50) responses generated at startup, or live via `Response`. Each candidate is parsed and rejected unless it contains ≥1 keyword token (`Count > 0`). The whole loop is bounded by a wall-clock budget `TimeFrame` (default 3 s, measured via `TooLong`).

**Re-ranking.** Each accepted candidate is scored by raw keyword-overlap count (`Matches[i]`). Ties: take the highest index, but if the winner carries the `#14` "ugly sentence" flag, downgrade in favor of any unflagged candidate with the same score (`daisy.pas:1785–1792`). The buffer pre-warm trades response novelty for latency on a 2000-era CPU.

In modern terms: this is a tiny **retrieval-rerank pipeline** — generate by Markov sampling, filter by keyword presence, score by lexical overlap with the IDF-weighted "important" words.

## 5. System glue

- **`CreateTermFile`** rebuilds `term.bfb` (the learned terminator n-gram set) from current memory each turn — DAISY's only "feature engineering" step.
- **`CreateBuffer`** pre-generates 50 candidates at startup to amortize Markov-scan cost.
- **Spell correction** (`CorrectSpell`) is human-in-the-loop curation: it walks every occurrence of a token in memory and asks the user, with context, whether to rewrite it.
- **UDLP2 / Link mode** lets two bots converse via on-disk handoff files (`udlp.nfo`, `chat.msg`) — each side runs the same generate-and-rerank loop on the peer's last utterance, and may learn from it (`LinkMode`, `daisy.pas:2042`).
- **`VocabCount(Exact)`** does a case-insensitive, punctuation-stripped deduplication pass to count types (vs. raw token count).

## 6. ML-relevant properties and limitations

- **Model class:** 1st-order Markov chain with stride-3 emission and empirically-proportional sampling. No smoothing → any unseen unigram dead-ends generation; the random sentence-start restart is the only recovery.
- **No probability estimation:** rates are encoded by raw multiplicity in a list. Memory grows linearly forever unless Learn Mode is toggled off; per-turn cost is O(N · pool_size · keyword_count).
- **Importance scoring:** min-frequency keyword selection is a degenerate IDF — sensitive to typos and proper nouns (which trivially win as "important"), exactly the failure mode the spell-correction UI is built to manage.
- **Reranker is lexical only:** keyword *presence count*, no semantic similarity, no embedding, no length normalization beyond the >70-char penalty.
- **Continuity:** `LastSubs` is the only cross-turn state; there is no dialogue act tracking, no user model, no decay.
- **No hard-coded language** is literally true — even sentence terminators are learned from the corpus into `term.bfb`. The "personality" of a `.DSY` file is fully determined by training transcripts, which is the design's main affordance.

## TL;DR

DAISY is a clean, minimal artifact of pre-statistical-NLP chatbotting: a linked-list corpus, a 1-gram Markov sampler with learned terminators, rarest-word keyword extraction as a stand-in for IDF, and a 10-candidate generate-filter-rerank loop bounded by a 3-second wall clock. Everything a modern LLM does in dense vector space, DAISY does with `strcmp` and `random()` over a flat token list — which is both its charm and its ceiling.
