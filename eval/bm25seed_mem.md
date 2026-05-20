# Eval — bm25seed-mem

_Generated 2026-05-20T05:50:31Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `classic` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `70` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.267 |
| ugliness rate (winner had ugly flag) | 0.067 |
| recitation rate (response = a corpus sentence verbatim) | 0.500 |
| acceptance rate (kept / attempted candidates) | 0.027 |
| distinct-2, across all trials | 0.177 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.558 |
| KL(responses ‖ corpus) bigrams, nats | 0.463 |
| latency p50 (ms) | 0.782 |
| latency p95 (ms) | 76.589 |
| KL drift from baseline `baseline-mem` (nats) | 0.538 |

Diagnostic counts (kept in JSON): mean attempts 276.573, mean kept 7.333, mean length 7.313 tokens, distinct-3 0.246.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | the most important thing about life is being happy. |
| hi daisy | daisy, are you fear humanity, daisy? |
| good morning | i feel good about myself. |
| how are you | daisy, you are you making fun person! |
| what do you like | i like to do unto you. |
| tell me about yourself | the most important thing about life is being happy. |
| what makes you happy | the most important thing about life is being happy. |
| what is your favorite | what have you want others to lower your expectations of other people. |
| i had a good day | it's a beautiful day outside! |
| the weather is nice today | where do you want to go today? |
| i feel tired | sometimes i feel like i need a vacation. |
| computers are fun | daisy, are you are not my life. |
| tell me about a platypus | the most important thing about life is being happy. |
| what about electricity | the most important thing about life is being happy. |
| i love astronomy | sometimes i feel like i need a vacation. |
| explain photosynthesis | the most important thing about life is being happy. |
| describe a unicorn | i'm at a true statement. |
| what do you think | do you ever traveled the world, daisy? |
| give me advice | rainy days give me the blues... |
| say something | you say some dumb things. |
| anything you want | do unto others as you want is a little respect. |
| and then what | that's what i play trombone and people will like to think that i don't even |
| really | the most important thing about life is being happy. |
| go on | let's go outside. |
| purple monkey dishwasher | the most important thing about life is being happy. |
| asdf | the most important thing about life is being happy. |
| the the the | i think the president of the sun sets. |
| i was wondering if you could tell me what you think about... | the most important thing about life is being happy. |
| do you have any thoughts on the future of technology | the most important thing about life is being happy. |
| imagine if computers could dream what would they dream about | the most important thing about life is being happy. |
