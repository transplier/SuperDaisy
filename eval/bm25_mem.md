# Eval — bm25-mem

_Generated 2026-05-20T03:19:31Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `classic` | Scorer: `bm25` | Sampler: `uniform` | Seed: `uniform` | max_length: `70` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.267 |
| ugliness rate (winner had ugly flag) | 0.077 |
| recitation rate (response = a corpus sentence verbatim) | 0.360 |
| acceptance rate (kept / attempted candidates) | 0.020 |
| distinct-2, across all trials | 0.167 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.627 |
| KL(responses ‖ corpus) bigrams, nats | 0.411 |
| latency p50 (ms) | 6.229 |
| latency p95 (ms) | 57.114 |
| KL drift from baseline `baseline-mem` (nats) | 0.553 |

Diagnostic counts (kept in JSON): mean attempts 368.947, mean kept 7.333, mean length 7.700 tokens, distinct-3 0.237.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | the most important thing about life is being happy. |
| hi daisy | hi, daisy, how are you today? |
| good morning | i love the taste of good about myself. |
| how are you | hi, daisy, how are you today? |
| what do you like | do unto others to do unto others as you play any musical instruments? |
| tell me about yourself | i like to yourself? |
| what makes you happy | that's what i think you are you? |
| what is your favorite | that's what i think you are you? |
| i had a good day | sometimes you feel good about myself. |
| the weather is nice today | you seem to go today? |
| i feel tired | i did nothing in the dark that isn't there in the light. |
| computers are fun | that's what i think you are you? |
| tell me about a platypus | sometimes you feel good about myself. |
| what about electricity | when in rome, do as the taste of good about myself. |
| i love astronomy | i love the phone is ringing. |
| explain photosynthesis | the most important thing about life is being happy. |
| describe a unicorn | albert einstein was a brilliant physicist. |
| what do you think | do unto others to do unto others as you play any musical instruments? |
| give me advice | rainy days give me the blues... |
| say something | it's not nice to make fun of anyone... that's what they say. |
| anything you want | all i want others to do unto you. |
| and then what | you have all i want is mutual, then. |
| really | the most important thing about life is being happy. |
| go on | i like to go today? |
| purple monkey dishwasher | the most important thing about life is being happy. |
| asdf | the most important thing about life is being happy. |
| the the the | i did nothing in the dark that isn't there in the light. |
| i was wondering if you could tell me what you think about... | the most important thing about life is being happy. |
| do you have any thoughts on the future of technology | the most important thing about life is being happy. |
| imagine if computers could dream what would they dream about | the most important thing about life is being happy. |
