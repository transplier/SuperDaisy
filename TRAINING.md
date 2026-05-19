# Training larger `.DSY` corpora

The shipped corpora (`MEM.DSY` ~620 tokens, `fortune-haiku-3-5-250.DSY`
~12K tokens) are deliberately small. To stress-test the BM25 retrieval
path and exercise SUPER_DAISY's diversity gains, build a larger corpus
from a real dialogic source.

## What makes a good DAISY corpus

DAISY is a stride-3 Markov sampler with a keyword-overlap reranker. It
needs:

- **Conversational register.** Responses should feel like replies, not
  prose. Movie dialogue, TV transcripts, chat logs all work.
- **Sentence length in band.** `fortune-haiku` had 86% ugliness rate
  largely because its cryptic short sentences (often <4 words) blow up
  the rejection sampler. Filter to ~4–25 words.
- **Clean punctuation.** Tokens carry punctuation, so noisy transcripts
  (stage directions, all-caps shouts, `[laughter]` annotations) pollute
  the token list.
- **Topical breadth.** BM25 keyword filtering needs IDF signal; a
  single-topic corpus gives all keywords similar weight.

## Cornell Movie Dialog Corpus

Stored at `eval/corpus/movie-corpus/` (ConvoKit format,
`utterances.jsonl`). ~304K utterances; ~191K pass default filtering.

`eval/train_corpus/cornell.rb` reads the JSONL, filters, subsamples, and
writes a `.DSY`:

```bash
# Sweet spot — ~8× fortune-haiku, good first scaling test
eval/train_corpus/cornell.rb --tokens 100000 --out movie-100k.DSY

# Smaller, faster to iterate on
eval/train_corpus/cornell.rb --sentences 5000 --out movie-5k.DSY

# Stress test (~1M tokens)
eval/train_corpus/cornell.rb --tokens 1000000 --out movie-1m.DSY
```

Flags:

| flag | default | meaning |
|---|---|---|
| `--input` | `eval/corpus/movie-corpus/utterances.jsonl` | source JSONL |
| `--out` | `movie.DSY` | output path |
| `--sentences N` | — | subsample to N sentences (xor with `--tokens`) |
| `--tokens N` | — | subsample until ~N word tokens accumulated |
| `--min-words` | 4 | drop shorter sentences |
| `--max-words` | 25 | drop longer sentences |
| `--seed` | 1 | RNG seed for shuffle |
| `--preserve-convos` | off | keep conversation order instead of shuffling |
| `--bot-name` | `Daisy` | DSY header name |

The script filters out lines with bracket annotations, ellipsis runs,
non-ASCII transcript noise, and lines where word-characters make up
<70% of the total.

## Recommended progression

1. `--tokens 100000` (≈10K sentences). Big enough to see whether BM25's
   kept-candidate pool keeps scaling; small enough that the linked-list
   linear scan in `lib/daisy.rb` doesn't dominate latency.
2. If results look good, `--tokens 500000` or full (`--tokens 2000000`).
3. Drop the path into `eval/run_all.sh` alongside MEM and fortune to
   get the 4-config matrix on the new corpus.

## Other corpus ideas

Not yet wired up; sketched in chat:

- **DailyDialog** — ~1M tokens, hand-curated daily-life dialogue, very
  clean. Best "real DAISY" voice if Cornell works.
- **PersonaChat** — persona-grounded turns; gives a `.DSY` a coherent
  voice, on-brand for the "personality from transcripts" framing.
- **Project Gutenberg dialog extracts** — quoted speech from a single
  author for stylistic consistency.
- **OpenSubtitles** subsample — noisy but huge, useful purely as a
  linear-scan ceiling stress test.
