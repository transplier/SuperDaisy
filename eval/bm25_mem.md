# Eval — bm25-mem

_Generated 2026-05-19T22:57:42Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `classic` | Scorer: `bm25` | max_length: `52` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.267 |
| ugliness rate (winner had ugly flag) | 0.110 |
| recitation rate (response = a corpus sentence verbatim) | 0.323 |
| acceptance rate (kept / attempted candidates) | 0.020 |
| distinct-2, across all trials | 0.176 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.654 |
| KL(responses ‖ corpus) bigrams, nats | 0.376 |
| latency p50 (ms) | 2.610 |
| latency p95 (ms) | 16.694 |
| KL drift from baseline `baseline-mem` (nats) | 0.624 |

Diagnostic counts (kept in JSON): mean attempts 369.907, mean kept 7.333, mean length 6.990 tokens, distinct-3 0.248.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | i have a true statement. |
| hi daisy | hi, daisy, how are you today? |
| good morning | daisy, are you ever traveled the taste of good food. |
| how are you | hi, daisy, how are you today? |
| what do you like | do you have any idea what i said. |
| tell me about yourself | i like to yourself? |
| what makes you happy | that's what i think you are you? |
| what is your favorite | that's what i think you are you? |
| i had a good day | i love the taste of good about myself. |
| the weather is nice today | you seem to go today? |
| i feel tired | sometimes i feel like a nut, sometimes you don't. |
| computers are fun | that's what i think you are you? |
| tell me about a platypus | i love the taste of good about myself. |
| what about electricity | when in rome, do as the taste of good about myself. |
| i love astronomy | i love the phone is ringing. |
| explain photosynthesis | i have a true statement. |
| describe a unicorn | sometimes you feel like i need a vacation. |
| what do you think | do you have any idea what i said. |
| give me advice | rainy days give me the blues... |
| say something | you say some dumb things. |
| anything you want | all i want others to do unto you. |
| and then what | what kind of animal is a real person, actually! |
| really | i have a true statement. |
| go on | i like to go today? |
| purple monkey dishwasher | i have a true statement. |
| asdf | i have a true statement. |
| the the the | i did nothing in the dark that isn't there in the light. |
| i was wondering if you could tell me what you think about... | i have a true statement. |
| do you have any thoughts on the future of technology | i have a true statement. |
| imagine if computers could dream what would they dream about | i have a true statement. |
