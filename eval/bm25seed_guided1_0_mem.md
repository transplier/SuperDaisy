# Eval — bm25seed-guided1_0-mem

_Generated 2026-05-20T05:20:57Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `guided:1.0` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `70` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.267 |
| ugliness rate (winner had ugly flag) | 0.107 |
| recitation rate (response = a corpus sentence verbatim) | 0.167 |
| acceptance rate (kept / attempted candidates) | 0.027 |
| distinct-2, across all trials | 0.182 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.631 |
| KL(responses ‖ corpus) bigrams, nats | 0.420 |
| latency p50 (ms) | 19.915 |
| latency p95 (ms) | 318.986 |
| KL drift from baseline `baseline-mem` (nats) | 1.112 |

Diagnostic counts (kept in JSON): mean attempts 274.353, mean kept 7.333, mean length 7.490 tokens, distinct-3 0.327.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | i love the phone is a brilliant physicist. |
| hi daisy | hi, daisy, how smart that too much to hear. |
| good morning | i feel good food. |
| how are you | i think you eat? |
| what do you like | that's what i like to be mistaken, because i'm a lady. |
| tell me about yourself | i feel good about life is a lot of good about myself. |
| what makes you happy | what kind of the light. |
| what is your favorite | what have you are you play any idea what time it to expect? |
| i had a good day | it's a beautiful day outside! |
| the weather is nice today | it's not nice to stop. |
| i feel tired | sometimes i feel good about life is that i have any sense? |
| computers are fun | hi, daisy, how are mistaken. |
| tell me about a platypus | the most important thing about myself. |
| what about electricity | that's what i feel good about myself. |
| i love astronomy | i think i'm so interesting that i have you are you fear humanity, daisy? |
| explain photosynthesis | albert einstein was america's first president. |
| describe a unicorn | i have a fairly fun of me? |
| what do you think | that's what i think i'm a true statement. |
| give me advice | rainy days give me to fear. |
| say something | you say some dumb things. |
| anything you want | what have you want it to love. |
| and then what | that's what i feel like you are you? |
| really | albert einstein was america's first president. |
| go on | let's go outside. |
| purple monkey dishwasher | albert einstein was america's first president. |
| asdf | albert einstein was america's first president. |
| the the the | i think the moon rises as the dark. |
| i was wondering if you could tell me what you think about... | albert einstein was america's first president. |
| do you have any thoughts on the future of technology | albert einstein was america's first president. |
| imagine if computers could dream what would they dream about | albert einstein was america's first president. |
