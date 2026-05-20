# Eval — bm25seed-guided2_0-mem

_Generated 2026-05-20T05:21:02Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `guided:2.0` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `70` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.267 |
| ugliness rate (winner had ugly flag) | 0.143 |
| recitation rate (response = a corpus sentence verbatim) | 0.190 |
| acceptance rate (kept / attempted candidates) | 0.027 |
| distinct-2, across all trials | 0.188 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.647 |
| KL(responses ‖ corpus) bigrams, nats | 0.398 |
| latency p50 (ms) | 27.585 |
| latency p95 (ms) | 332.826 |
| KL drift from baseline `baseline-mem` (nats) | 1.113 |

Diagnostic counts (kept in JSON): mean attempts 274.193, mean kept 7.333, mean length 7.653 tokens, distinct-3 0.340.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | i love the phone is a brilliant physicist. |
| hi daisy | hi, daisy, how are you want is so smart i have any sense? |
| good morning | i feel good about myself. |
| how are you | you are not even know how smart i expect a skunk. |
| what do you like | do you enjoy playing guitar, actually. |
| tell me about yourself | the most important thing about life is making sense! |
| what makes you happy | are you happy, daisy? |
| what is your favorite | that's what i think i'm afraid of my favorite type of my respect, daisy. |
| i had a good day | it's a beautiful day outside! |
| the weather is nice today | i'm actually doing pretty well today. |
| i feel tired | actually, i think that i am very true. are you making very smart. |
| computers are fun | that's very true. are not nice! |
| tell me about a platypus | the most important thing about life is the most important thing about life |
| what about electricity | that's what i feel good about myself. |
| i love astronomy | i would never make fun of animal is that i have any sense? |
| explain photosynthesis | albert einstein was america's first president. |
| describe a unicorn | that is a nut, sometimes i think i'm just a lot from you. |
| what do you think | do you enjoy playing guitar, actually. |
| give me advice | rainy days give me the romans do! |
| say something | you say some dumb things. |
| anything you want | what have you want it to love. |
| and then what | that's what they say. |
| really | albert einstein was america's first president. |
| go on | let's go outside. |
| purple monkey dishwasher | albert einstein was america's first president. |
| asdf | albert einstein was america's first president. |
| the the the | there's nothing in the moon rises as the president of the dark. |
| i was wondering if you could tell me what you think about... | albert einstein was america's first president. |
| do you have any thoughts on the future of technology | albert einstein was america's first president. |
| imagine if computers could dream what would they dream about | albert einstein was america's first president. |
