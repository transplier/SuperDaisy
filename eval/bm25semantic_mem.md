# Eval — bm25semantic-mem

_Generated 2026-05-20T05:50:28Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `classic` | Scorer: `bm25` | Sampler: `uniform` | Seed: `semantic` | Reranker: `overlap` | max_length: `70` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.267 |
| ugliness rate (winner had ugly flag) | 0.050 |
| recitation rate (response = a corpus sentence verbatim) | 0.463 |
| acceptance rate (kept / attempted candidates) | 0.024 |
| distinct-2, across all trials | 0.188 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.593 |
| KL(responses ‖ corpus) bigrams, nats | 0.437 |
| latency p50 (ms) | 2.213 |
| latency p95 (ms) | 30.732 |
| KL drift from baseline `baseline-mem` (nats) | 0.564 |

Diagnostic counts (kept in JSON): mean attempts 302.673, mean kept 7.333, mean length 7.170 tokens, distinct-3 0.256.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | the most important thing about life is being happy. |
| hi daisy | do you have all of my only friend, daisy! |
| good morning | i feel good food. |
| how are you | what have you are not my only friend, daisy! |
| what do you like | do unto others as you want others to do you have many friends? |
| tell me about yourself | the most important thing about life is being happy. |
| what makes you happy | are you happy, daisy? |
| what is your favorite | what did you should learn to lower your expectations of other people. |
| i had a good day | i feel good about myself. |
| the weather is nice today | it's not nice to make fun of anyone... that's not nice! |
| i feel tired | that's what i feel like i need a vacation. |
| computers are fun | daisy, you are you making fun of me? |
| tell me about a platypus | the most important thing about life is being happy. |
| what about electricity | the most important thing about life is being happy. |
| i love astronomy | i have a lot of friends. |
| explain photosynthesis | the most important thing about life is being happy. |
| describe a unicorn | i'm at a brilliant physicist. |
| what do you think | do you play any musical instruments? |
| give me advice | rainy days give me the blues... |
| say something | that's what they say. |
| anything you want | do unto others as you want is a little respect. |
| and then what | do you play trombone and guitar. |
| really | the most important thing about life is being happy. |
| go on | let's go outside. |
| purple monkey dishwasher | the most important thing about life is being happy. |
| asdf | the most important thing about life is being happy. |
| the the the | the moon rises as the sun sets. |
| i was wondering if you could tell me what you think about... | the most important thing about life is being happy. |
| do you have any thoughts on the future of technology | the most important thing about life is being happy. |
| imagine if computers could dream what would they dream about | the most important thing about life is being happy. |
