# Eval — bm25seed-ppm2-mem

_Generated 2026-05-20T03:39:30Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `ppm:2` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `70` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.267 |
| ugliness rate (winner had ugly flag) | 0.013 |
| recitation rate (response = a corpus sentence verbatim) | 0.740 |
| acceptance rate (kept / attempted candidates) | 0.027 |
| distinct-2, across all trials | 0.159 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.539 |
| KL(responses ‖ corpus) bigrams, nats | 0.480 |
| latency p50 (ms) | 1.020 |
| latency p95 (ms) | 96.100 |
| KL drift from baseline `baseline-mem` (nats) | 1.404 |

Diagnostic counts (kept in JSON): mean attempts 274.893, mean kept 7.333, mean length 6.483 tokens, distinct-3 0.176.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | albert einstein was a brilliant physicist. |
| hi daisy | daisy, are you happy, daisy? |
| good morning | i love the taste of good food. |
| how are you | hi, daisy, how are you today? |
| what do you like | what kind of foods do you eat? |
| tell me about yourself | i feel good about myself. |
| what makes you happy | do you have any idea what time it is? |
| what is your favorite | do you have any idea what time it is? |
| i had a good day | i love the taste of good food. |
| the weather is nice today | hi, daisy, how are you today? |
| i feel tired | sometimes i feel like i need a vacation. |
| computers are fun | hi, daisy, how are you making fun of anyone... that's not nice! |
| tell me about a platypus | the most important thing about life is being happy. |
| what about electricity | do you have any idea what time it is? |
| i love astronomy | i love the taste of good food. |
| explain photosynthesis | albert einstein was a brilliant physicist. |
| describe a unicorn | i have a lot of friends. |
| what do you think | do you have any idea what time it is? |
| give me advice | rainy days give me the blues... |
| say something | that's what they say. |
| anything you want | do unto others as you want to go today? |
| and then what | spread happiness, and people will like you more. |
| really | albert einstein was a brilliant physicist. |
| go on | let's go outside. |
| purple monkey dishwasher | albert einstein was a brilliant physicist. |
| asdf | albert einstein was a brilliant physicist. |
| the the the | bill clinton is the president of the real world. |
| i was wondering if you could tell me what you think about... | albert einstein was a brilliant physicist. |
| do you have any thoughts on the future of technology | albert einstein was a brilliant physicist. |
| imagine if computers could dream what would they dream about | albert einstein was a brilliant physicist. |
