# Eval — ppm-mem

_Generated 2026-05-20T05:20:50Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `ppm:4` | Scorer: `classic` | Sampler: `uniform` | Seed: `uniform` | Reranker: `overlap` | max_length: `70` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.767 |
| ugliness rate (winner had ugly flag) | 0.000 |
| recitation rate (response = a corpus sentence verbatim) | 1.000 |
| acceptance rate (kept / attempted candidates) | 0.003 |
| distinct-2, across all trials | 0.104 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.754 |
| KL(responses ‖ corpus) bigrams, nats | 0.940 |
| latency p50 (ms) | 62.268 |
| latency p95 (ms) | 140.011 |
| KL drift from baseline `baseline-mem` (nats) | 1.329 |

Diagnostic counts (kept in JSON): mean attempts 859.213, mean kept 2.233, mean length 6.500 tokens, distinct-3 0.113.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | have you ever traveled the world, daisy? |
| hi daisy | hi, daisy, how are you today? |
| good morning | have you ever traveled the world, daisy? |
| how are you | hi, daisy, how are you today? |
| what do you like | that's what i like to hear. |
| tell me about yourself | have you ever traveled the world, daisy? |
| what makes you happy | have you ever traveled the world, daisy? |
| what is your favorite | you should learn to lower your expectations of other people. |
| i had a good day | have you ever traveled the world, daisy? |
| the weather is nice today | have you ever traveled the world, daisy? |
| i feel tired | have you ever traveled the world, daisy? |
| computers are fun | have you ever traveled the world, daisy? |
| tell me about a platypus | have you ever traveled the world, daisy? |
| what about electricity | have you ever traveled the world, daisy? |
| i love astronomy | have you ever traveled the world, daisy? |
| explain photosynthesis | have you ever traveled the world, daisy? |
| describe a unicorn | have you ever traveled the world, daisy? |
| what do you think | what kind of foods do you eat? |
| give me advice | have you ever traveled the world, daisy? |
| say something | have you ever traveled the world, daisy? |
| anything you want | have you ever traveled the world, daisy? |
| and then what | the feeling is mutual, then. |
| really | have you ever traveled the world, daisy? |
| go on | have you ever traveled the world, daisy? |
| purple monkey dishwasher | have you ever traveled the world, daisy? |
| asdf | have you ever traveled the world, daisy? |
| the the the | bill clinton is the president of the usa. |
| i was wondering if you could tell me what you think about... | have you ever traveled the world, daisy? |
| do you have any thoughts on the future of technology | have you ever traveled the world, daisy? |
| imagine if computers could dream what would they dream about | have you ever traveled the world, daisy? |
