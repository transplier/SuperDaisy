# Eval — full-mem

_Generated 2026-05-20T05:50:33Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `ppm:4` | Scorer: `bm25` | Sampler: `uniform` | Seed: `uniform` | Reranker: `overlap` | max_length: `70` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.267 |
| ugliness rate (winner had ugly flag) | 0.000 |
| recitation rate (response = a corpus sentence verbatim) | 1.000 |
| acceptance rate (kept / attempted candidates) | 0.019 |
| distinct-2, across all trials | 0.160 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.542 |
| KL(responses ‖ corpus) bigrams, nats | 0.429 |
| latency p50 (ms) | 12.379 |
| latency p95 (ms) | 83.506 |
| KL drift from baseline `baseline-mem` (nats) | 1.056 |

Diagnostic counts (kept in JSON): mean attempts 385.027, mean kept 7.333, mean length 6.927 tokens, distinct-3 0.173.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | have you ever traveled the world, daisy? |
| hi daisy | hi, daisy, how are you today? |
| good morning | i love the taste of good food. |
| how are you | are you happy, daisy? |
| what do you like | do unto others as you want others to do unto you. |
| tell me about yourself | i feel good about myself. |
| what makes you happy | what did you do today? |
| what is your favorite | you should learn to lower your expectations of other people. |
| i had a good day | i love the taste of good food. |
| the weather is nice today | it's not nice to make fun of people. |
| i feel tired | i think i'm happier now than i have ever been in my life. |
| computers are fun | that's very true. are you making fun of me? |
| tell me about a platypus | i feel good about myself. |
| what about electricity | the most important thing about life is being happy. |
| i love astronomy | i think i'm happier now than i have ever been in my life. |
| explain photosynthesis | have you ever traveled the world, daisy? |
| describe a unicorn | i'm at a loss for words. |
| what do you think | do unto others as you want others to do unto you. |
| give me advice | sports just aren't for me. |
| say something | you say some dumb things. |
| anything you want | where do you want to go today? |
| and then what | what have you been up to lately, daisy? |
| really | have you ever traveled the world, daisy? |
| go on | let's go outside. |
| purple monkey dishwasher | have you ever traveled the world, daisy? |
| asdf | have you ever traveled the world, daisy? |
| the the the | bill clinton is the president of the usa. |
| i was wondering if you could tell me what you think about... | have you ever traveled the world, daisy? |
| do you have any thoughts on the future of technology | have you ever traveled the world, daisy? |
| imagine if computers could dream what would they dream about | have you ever traveled the world, daisy? |
