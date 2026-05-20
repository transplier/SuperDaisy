# Eval — ppm2-mem

_Generated 2026-05-20T03:39:39Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `ppm:2` | Scorer: `classic` | Sampler: `uniform` | Seed: `uniform` | Reranker: `overlap` | max_length: `70` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.767 |
| ugliness rate (winner had ugly flag) | 0.027 |
| recitation rate (response = a corpus sentence verbatim) | 0.817 |
| acceptance rate (kept / attempted candidates) | 0.003 |
| distinct-2, across all trials | 0.135 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.848 |
| KL(responses ‖ corpus) bigrams, nats | 0.757 |
| latency p50 (ms) | 41.635 |
| latency p95 (ms) | 92.403 |
| KL drift from baseline `baseline-mem` (nats) | 1.820 |

Diagnostic counts (kept in JSON): mean attempts 863.233, mean kept 2.290, mean length 5.553 tokens, distinct-3 0.152.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | albert einstein was a brilliant physicist. |
| hi daisy | hi, daisy, how are you in love? |
| good morning | albert einstein was a brilliant physicist. |
| how are you | hi, daisy, how are you making fun of anyone... that's not nice! |
| what do you like | sometimes i feel like a nut, sometimes you feel like a nut, sometimes you |
| tell me about yourself | albert einstein was a brilliant physicist. |
| what makes you happy | albert einstein was a brilliant physicist. |
| what is your favorite | you should learn to lower your expectations of other people. |
| i had a good day | albert einstein was a brilliant physicist. |
| the weather is nice today | albert einstein was a brilliant physicist. |
| i feel tired | albert einstein was a brilliant physicist. |
| computers are fun | albert einstein was a brilliant physicist. |
| tell me about a platypus | albert einstein was a brilliant physicist. |
| what about electricity | albert einstein was a brilliant physicist. |
| i love astronomy | albert einstein was a brilliant physicist. |
| explain photosynthesis | albert einstein was a brilliant physicist. |
| describe a unicorn | albert einstein was a brilliant physicist. |
| what do you think | i like to think that i'm a fairly fun person! |
| give me advice | albert einstein was a brilliant physicist. |
| say something | albert einstein was a brilliant physicist. |
| anything you want | albert einstein was a brilliant physicist. |
| and then what | the feeling is mutual, then. |
| really | albert einstein was a brilliant physicist. |
| go on | albert einstein was a brilliant physicist. |
| purple monkey dishwasher | albert einstein was a brilliant physicist. |
| asdf | albert einstein was a brilliant physicist. |
| the the the | there's nothing in the dark that isn't there in the light. |
| i was wondering if you could tell me what you think about... | albert einstein was a brilliant physicist. |
| do you have any thoughts on the future of technology | albert einstein was a brilliant physicist. |
| imagine if computers could dream what would they dream about | albert einstein was a brilliant physicist. |
