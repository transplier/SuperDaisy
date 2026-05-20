# Daisy's Journey

A small chatbot from the year 2000 walked into 2026 and got a thoughtful
upgrade. Here's what happened, what worked, what didn't, and what we
learned about the spirit of a 25-year-old toy.

## Meet DAISY

DAISY v1.1 was written in 2000 by Greg Leedberg, in Free Pascal, for DOS.
She's a chatbot — but a peculiar one. She doesn't ship with any
pre-programmed knowledge. She starts knowing nothing, and learns by
appending every input she sees to a flat list of tokens. To respond, she
walks randomly through that list, joining together short verbatim chunks
of past inputs and stopping when she stumbles into a sentence ending she's
seen before.

That's it. No grammar. No semantics. No "model" in the modern sense. Just
a token list, a Markov walk, and a few heuristics. The result is famous
in a small way: she occasionally says something profound by accident, but
mostly says off-topic nonsense in the voice of whoever taught her.

The goal of this project was to **preserve what makes her DAISY** while
exploring how much modern NLP we could bolt on without losing that voice.

---

## Step 1: A faithful Ruby port

The first job was just to get her running outside DOS. The original is
~2400 lines of Pascal tangled with BIOS calls and inline assembly for
cursor control. We ported the algorithm to Ruby, kept the `.DSY` file
format intact (so the original 25-year-old memory file still works), and
threw out everything that was DOS-specific (popup windows, F-key menus,
the per-character typing animation).

What we kept verbatim: the linked-list-of-tokens corpus structure, the
"pick a random sentence start and Markov-walk from there" generator, the
rarest-word-wins keyword filter, the rerank-by-keyword-overlap step. The
canonical DAISY pipeline.

What we documented: a [`DAISY.md`](DAISY.md) technical writeup explaining
how she works to a modern ML reader. (Spoiler: it's roughly the shape of
a modern LLM pipeline, except every component is one line of Pascal.)

This was the easy part. The hard part was the next bit.

---

## Step 2: Super-DAISY — making her pluggable

The original DAISY is a monolith. To experiment, we needed to be able to
swap out pieces of her pipeline without breaking everything else. We
identified seven stages — tokenize input, score input importance,
generate candidate responses, filter candidates, rerank survivors, carry
memory across turns, and sample at decision points — and built each as a
small interchangeable component.

Then we wrote a design document, [`SUPER_DAISY.md`](SUPER_DAISY.md),
naming the **kernel** — the parts of DAISY's character we considered
non-negotiable:

1. She can only say what she's seen. Every word in her output comes
   verbatim from her corpus.
2. Learning is corpus append. No gradient descent, no model fitting.
3. Generation is a walk through her memory.
4. Her famous incoherence is a feature.

The plug-and-play architecture meant any upgrade had to fit one of the
seven slots. The kernel rules meant any upgrade had to be a kernel-
respecting variant. The combination gave us a structured place to ask:
"how much of modern NLP can fit through this filter?"

---

## Step 3: How to know if we're making it better

Before we changed anything, we needed to measure. Modern ML evaluations
are usually about accuracy on a test set; there's no such thing for a
chatbot. So we cobbled together a few metrics that capture different
parts of "is she still DAISY?":

- **Fallthrough rate** — how often her keyword filter fails and she just
  emits a random sentence. Counterintuitively, this is *the* signature
  DAISY move. We watch it carefully.
- **Recitation rate** — how often she emits a word-for-word copy of a
  corpus sentence. High = she stopped generating and started reciting.
- **Diversity** — how varied her outputs are, both across prompts and
  within repeated runs of the same prompt.
- **KL divergence** — a statistical measure of how different the
  distribution of bigrams in her output is from the baseline. Spikes here
  mean we changed her writing style noticeably.
- **Latency** — how fast she responds. She's small; this should stay
  fast.

We picked 30 prompts (greetings, questions, weird non-sequiturs,
philosophy), ran them at 10 random seeds each, and recorded everything in
a comparison matrix. That harness, plus a re-run script, became the
infrastructure for every subsequent experiment.

We also picked four corpora to test on, deliberately covering different
shapes:

- **MEM.DSY** — the original 92 sentences shipped with DAISY in 2000
- **fortune-haiku** — 250 long, oracular sentences (mean ~50 tokens each)
- **movie-5k** and **movie-100k** — 5K and 8K lines from the Cornell
  Movie Dialog corpus, short conversational fragments

This turned out to matter a lot.

---

## The upgrades, in roughly the order we learned things

### BM25: the boring upgrade that changed everything

The original DAISY decides which words in your prompt to "pay attention
to" by picking the rarest ones. There's a problem: a word she's never
seen has zero frequency — which trivially makes it the rarest. So whenever
you mention something not in her corpus, she fixates on that and then
can't find any response that contains it. She gives up and emits a random
sentence (high fallthrough). That's a lot of her famous incoherence right
there: she's filter-blocked on words she can't possibly know.

**BM25** is a search-engine ranking formula from the 1990s. We borrowed
just its IDF piece — score each prompt word by how informative it is,
prefer the most informative ones that *actually exist* in the corpus.

This was the single biggest character-preserving improvement we made.
Fallthrough rate dropped by 30-50 percentage points on every corpus.
Diversity went up. Latency improved. And the statistical drift from
canonical DAISY was the smallest of any swap we'd tested — outputs
*looked* like DAISY, just less broken.

### Prompt-aware seed selection: the obvious-in-hindsight win

DAISY's generator is completely blind to the prompt. She picks a random
sentence in her corpus and walks from there; the prompt only influences
which of her random walks get *kept*. With BM25 finding three good
keywords and her rejection sampler grinding through ~1000 candidate walks
hoping to land near one, this is shockingly inefficient.

The fix: bias her opening move. When she picks a sentence to start
walking from, prefer sentences that contain a prompt keyword. Walker
behavior is otherwise unchanged. Falls back to uniform random when no
match exists.

This was the second-biggest win. Latency on the fortune corpus dropped
6× — because the rejection sampler fills its pool in far fewer attempts
when seeds are already topical. Diversity went up another 17% on the
movie corpora. And the qualitative chat got *noticeably more
conversational* — instead of "you don't move, you understand?! it's
talkradio. you're on these operations," we got responses like "are you
okay?"

### PPM: the historical detour

PPM (Prediction by Partial Matching) is a 1990s text-modeling technique:
a Markov walker with variable-length context, backing off from 4-grams to
3-grams to bigrams to unigrams as needed. It was state-of-the-art for
text compression at the time. We expected it to make DAISY more fluent.

It did — but with a catch we hadn't seen coming. **High-order PPM doesn't
just become fluent; it recites.** With order 4 on the original MEM.DSY,
*every single response* was a verbatim corpus sentence. The bot stopped
generating and started picking. The diversity metrics missed this
entirely (reciting *different* sentences still scores as varied).

We added a "recitation rate" metric, traced the problem, and discovered
something genuinely surprising: **recitation is driven by sentence
length, not corpus size**. A corpus of 10,000 short dialogue lines
recited 80% of the time with PPM:4. A corpus of 250 long oracular
sentences barely recited at all. The reason: short sentences don't give
the walker room to actually choose; long ones do.

Verdict: PPM:2 (bigram context with unigram backoff) is the sweet spot
for movie-style corpora. PPM:4 is contraindicated for any corpus with
short sentences. Available as an opt-in.

### Temperature: a clean negative result

Modern LLMs use a "temperature" knob to control how confidently they
sample. Low temperature = more predictable, more coherent. High = more
chaotic. We tried it.

It hurt. Across every metric. On every corpus.

Why: low temperature concentrates the sampler on the single most-common
continuation at each branch. That makes generated sentences converge to a
small set of "popular" corpus paths. The rejection sampler then can't
find keyword-bearing *variations* of them, so fallthrough rises and the
loop runs to the wall-clock timeout. Latency jumped from ~25ms to the
500ms cap on the bigger corpora.

The lesson worth keeping: **DAISY's incoherence isn't local-choice
noise** — it's that her generator has no awareness of the prompt at all.
Making each step "more confident" doesn't fix that; it just collapses
diversity. Temperature was the wrong dial.

We kept the component pluggable but removed it from the recommended
configs.

### Density rerank: a length knob

After generating candidates, DAISY scores them by raw keyword overlap —
a 12-word response with 1 keyword ties with a 6-word response with 1
keyword. Switching to keyword *density* (keywords per token) prefers the
shorter one.

Effect: mean response length dropped ~50% across every corpus. Diversity
took a small hit, recitation ticked up modestly (shorter outputs are more
likely to coincide with corpus sentences). But on dialogue corpora, the
shorter outputs read as more conversational. Stacked with PPM:2 on
movie-100k, you get the most chat-shaped responses we ever measured.
Things like "are you okay?" / "so, do you mean?" / "maybe he doesn't
know it."

Available as opt-in for chat use.

### Embeddings: the closeout

The natural endpoint of the pre-LLM exploration was *embeddings*.
Everything to this point had been either pure counting (BM25, the
keyword filter, the density reranker) or a Markov walker (classic,
PPM, plus the prompt-aware seed). None of it knew that "platypus" and
"wombat" might have anything in common. Embeddings are the classical
late-90s answer to that question, and they sit right on the edge of
the kernel rules.

**PPMI** (positive pointwise mutual information) captures which words
tend to co-occur in the corpus. **SVD** (singular value decomposition)
compresses that co-occurrence matrix into compact dense vectors — one
50-dimensional "embedding" per word. This is the technique behind
LSA/LSI in the late 90s, and the conceptual ancestor of word2vec.

Why this is the "gray zone": the SVD step is a *fit step*. Not gradient
descent, but a matrix factorization — which is more fit-y than the rest
of DAISY's "just count things" approach. We did it anyway, partly to
see what dense embeddings would buy us and partly as a demonstration
that the architecture can absorb a dense-embedding swap if the kernel
rules ever shift. The implementation is pure Ruby, no gems — a
truncated symmetric eigendecomposition via power iteration with
deflation, about 70 lines.

The embeddings closeout ended up being three connected things, not
one. We expected only the first; the others showed up along the way.

**1. A semantic seed selector.** The first job to give the embeddings
was the same one the literal-keyword version did: pick the walker's
starting sentence by which corpus sentence sits closest to the prompt
centroid. It worked, in the sense that the architecture absorbed it
cleanly. But the metric story was curious. On the *movie* corpora it
gave *less* diverse outputs than the literal-keyword version — the
embeddings collapse semantically-related sentences into a tighter
neighborhood than the broader "contains the keyword" pool. On smaller,
more topical corpora (fortune, MEM) it was a small win, because there
aren't enough literal matches there for the literal version to find,
so it falls back to uniform too often. Mixed verdict on the metric;
clean verdict on the architecture.

**2. Caching the SVD.** The SVD takes about a minute on the bigger
corpora, which is annoying if you're computing it every time the bot
starts up. We added a small on-disk cache, keyed by a hash of the
corpus contents and the embedding parameters. First call against a new
corpus pays the minute; every subsequent call is essentially free.
The co-occurrence-matrix build is also fork-parallelized — the only
truly parallel step in the project, because it's embarrassingly so:
each fork counts co-occurrences for its slice of the corpus, and the
parent sums the counts.

**3. The actual interesting use.** Having built the embeddings, the
obvious next question was whether to use them more invasively — to
*guide* the generation itself, not just the seed.

The naive version of this is exactly the "guided decoding" we'd ruled
out earlier as character-altering: bias every Markov branch toward
words near the prompt. It collapses output diversity by pulling every
step toward the same target.

But there's a clever variant. At each branch, instead of asking "does
this candidate word look like the prompt?", ask **"does the running
utterance, including this candidate word, look like the prompt?"** —
where "running utterance" means the average embedding of the words
emitted so far plus the candidate.

This single change has a surprising property: **the bias decays
naturally with sentence length**. The mean of N+1 embeddings barely
differs from the mean of N embeddings once N is moderately large. So
the topical pull is strong at the start of generation (where it
matters most for committing to a topic) and essentially zero by the
tail of the sentence (where DAISY's signature non-sequitur drift
needs room to happen).

We built it and ran an α sweep over the strength of the pull. Two
surprises:

- **Recitation drops sharply.** On MEM, from 50% verbatim to 18%. On
  movie-100k, from 2.3% down to under 1%. The guided walker has more
  incentive to *deviate* from corpus paths than the unbiased one,
  because the embedding-space target gives it a "reward signal"
  beyond raw frequency.

- **Per-prompt diversity goes *up*, not down.** Every corpus showed
  *more* variety per prompt. Counterintuitive for a "bias toward
  something" technique, but explainable: the bias is positive pressure
  toward a *neighborhood* in embedding space, not toward a *specific*
  word. The walker still explores freely within that neighborhood.

α had almost no effect across 0.5–2.0. The growing-centroid decay
flattens it; direction matters more than strength.

The catch is performance. At each Markov step we compute a cosine
similarity for every candidate next-word, which is fast in vectorized
languages but slow in pure Ruby. On the bigger corpora we ended up
needing to bump the wall-clock budget (in the eval matrix only) from
0.5 to 5 seconds to get readings that weren't truncated. Latency at
p50 is roughly 600-900ms — interactive-tolerable but heavy.

KL drift from baseline tells the cleanest character story: fine on
movie corpora (~0.4 nats, under the reconsider threshold), borderline
on fortune (~0.7), badly over on MEM (~1.1). The drift correlates with
how short the corpus's sentences are: shorter sentences mean the bias
stays meaningful longer, so it shifts the output style more.

Available as `--generator guided[:ALPHA]`. Not enabled by default —
the latency is too rough, and we'd want to vectorize the inner loop
before promoting it.

What the embeddings closeout taught us, beyond the metric story: the
*shape* of an intervention matters more than the fact of it. The same
"bias toward the prompt" idea is either a character-killer or a quiet
improvement depending on whether the bias decays. That's the kind of
lesson you can't get by arguing about designs in the abstract — you
have to build it and measure.

---

## What we learned about DAISY

Several things, some of which surprised us:

1. **Her famous incoherence is mostly a single bug**, and it has a fix
   that preserves character. The rarest-word-wins keyword rule trips on
   any word she hasn't seen, which is most words. Replace with proper
   IDF (BM25), and the bot suddenly engages with prompts properly while
   still sounding like DAISY. Most of the magic in modern ML — relative
   to canonical DAISY — comes from this kind of careful keyword handling,
   not from any single big architectural shift.

2. **Recitation is a length problem, not a model problem.** A model with
   higher context (PPM:4) doesn't fail on small corpora because the
   corpus is small; it fails because the sentences are short. The
   walker doesn't have room to make choices before the sentence ends.

3. **The "kernel" framing was load-bearing.** Without it, every modern
   idea we tried would have slowly pulled DAISY toward being a generic
   chatbot. With it, we could check each experiment against an explicit
   list of "is this still her?" and reject swaps that crossed the line
   (Option 3 from `SUPER_DAISY.md`, the temperature variant).

4. **A negative result is just as useful as a positive one** when the
   evaluation harness is solid. Temperature was a clean rejection; we
   know why, and we know the lesson generalizes — local-choice noise
   isn't her problem.

5. **The architecture absorbed every kernel-respecting swap without
   strain.** Even the PPMI+SVD experiment, which we expected to be
   invasive, fit into a single component slot.

6. **Bias-with-decay is not the same as bias.** The guided generator
   would have been a character disaster as a fixed-strength pull at
   every step. The growing-centroid trick — where the bias attenuates
   naturally as the sentence grows — is what lets it improve recitation
   *and* diversity at the same time. The shape of the intervention
   mattered more than the existence of it.

---

## What's still on the table

Two things remain undone, and we wrote them up in
[`SUPER_DAISY.md`](SUPER_DAISY.md) for whoever picks this up next:

- **Bidirectional walk from keyword anchor** — find a position in the
  corpus where a keyword appears, walk backward to a sentence-start
  neighborhood, then forward. Guarantees the keyword appears in every
  response. Moderate character impact (forces topicality).
- **K-turn conversation memory** — remember keywords across multiple
  turns of a chat, not just one. Needs a multi-turn eval harness we
  haven't built.

And one practical follow-up that would unlock more:

- **Vectorize the guided walker's per-step math** (e.g., via `numo-narray`).
  The current pure-Ruby cosine loop is what keeps latency around a
  second on the bigger corpora; a vectorized inner loop would make
  the guided generator viable as a default rather than an opt-in
  curiosity. The trade-off is bringing in a non-stdlib dependency,
  which we've held off on so far.

Anything beyond that is either modern ML (RLHF, learned rerankers) or
explicitly outside her kernel (RAG over external corpora, neural
language models). Those would be a different bot wearing her name.

---

## TL;DR

DAISY is a 2000-era chatbot whose famous incoherence turns out to be
mostly fixable by replacing one bad keyword-extraction rule with BM25.
Adding prompt-aware seed selection on top makes her significantly more
dialogue-shaped while keeping her sounding like herself. Most other
modern techniques either work fine within her architectural pattern
(PPM variable-order Markov, PPMI+SVD embeddings), can be made to work
with the right twist (the growing-centroid guided walker reduces
recitation and increases diversity simultaneously, surprisingly), or
fail to help (temperature sampling collapses diversity). The biggest
lesson: when you're updating a small, opinionated piece of software,
name the kernel first, measure relentlessly, let the negative results
land — and pay attention to the *shape* of every intervention, not
just whether you decided to do it. Some old bots have more to teach
you than you think.
