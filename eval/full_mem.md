# Eval — full-mem

_Generated 2026-05-19T22:57:43Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `ppm:4` | Scorer: `bm25` | max_length: `52` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.267 |
| ugliness rate (winner had ugly flag) | 0.067 |
| recitation rate (response = a corpus sentence verbatim) | 1.000 |
| acceptance rate (kept / attempted candidates) | 0.019 |
| distinct-2, across all trials | 0.159 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.551 |
| KL(responses ‖ corpus) bigrams, nats | 0.456 |
| latency p50 (ms) | 4.207 |
| latency p95 (ms) | 23.763 |
| KL drift from baseline `baseline-mem` (nats) | 1.184 |

Diagnostic counts (kept in JSON): mean attempts 385.460, mean kept 7.333, mean length 6.720 tokens, distinct-3 0.174.

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
| what is your favorite | what have you been up to lately, daisy? |
| i had a good day | i love the taste of good food. |
| the weather is nice today | it's not nice to make fun of people. |
| i feel tired | i'm so smart that i don't even know how smart i am. |
| computers are fun | that's very true. are you making fun of me? |
| tell me about a platypus | i feel good about myself. |
| what about electricity | the most important thing about life is being happy. |
| i love astronomy | i love the taste of good food. |
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
