# Eval — bm25t07-mem

_Generated 2026-05-20T03:39:53Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `classic` | Scorer: `bm25` | Sampler: `temperature:0.7` | Seed: `uniform` | Reranker: `overlap` | max_length: `70` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.267 |
| ugliness rate (winner had ugly flag) | 0.073 |
| recitation rate (response = a corpus sentence verbatim) | 0.367 |
| acceptance rate (kept / attempted candidates) | 0.020 |
| distinct-2, across all trials | 0.175 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.664 |
| KL(responses ‖ corpus) bigrams, nats | 0.373 |
| latency p50 (ms) | 56.048 |
| latency p95 (ms) | 277.751 |
| KL drift from baseline `baseline-mem` (nats) | 1.088 |

Diagnostic counts (kept in JSON): mean attempts 367.890, mean kept 7.333, mean length 7.747 tokens, distinct-3 0.245.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | bill clinton is that too much to expect? |
| hi daisy | hi, daisy, how are you today? |
| good morning | i feel good food. |
| how are you | daisy, you are you? |
| what do you like | do unto others to do unto others as you play any musical instruments? |
| tell me about yourself | i watch tv, but only when in rome, do you ever listen to yourself? |
| what makes you happy | this conversation is being happy. |
| what is your favorite | that's what i have ever been up to lately, daisy? |
| i had a good day | i would never make fun of good food. |
| the weather is nice today | you seem to go today? |
| i feel tired | i feel good about myself. |
| computers are fun | i would never make fun of foods do you are not my life. |
| tell me about a platypus | i feel good about myself. |
| what about electricity | what did you today? |
| i love astronomy | i'm not even know how smart that i don't even know how smart i am. |
| explain photosynthesis | bill clinton is that too much to expect? |
| describe a unicorn | albert einstein was a brilliant physicist. |
| what do you think | do unto others to do unto others as you play any musical instruments? |
| give me advice | rainy days give me the blues... |
| say something | that's what they say. |
| anything you want | daisy, you are you? |
| and then what | that's what i have ever been up to lately, daisy? |
| really | bill clinton is that too much to expect? |
| go on | i think you want to go outside. |
| purple monkey dishwasher | bill clinton is that too much to expect? |
| asdf | bill clinton is that too much to expect? |
| the the the | the moon rises as the sun sets. |
| i was wondering if you could tell me what you think about... | bill clinton is that too much to expect? |
| do you have any thoughts on the future of technology | bill clinton is that too much to expect? |
| imagine if computers could dream what would they dream about | bill clinton is that too much to expect? |
