# Eval — bm25seed-guided0_5-mem

_Generated 2026-05-20T05:37:38Z by `bin/eval`._

Corpus: `daisy11 original freepascal/MEM.DSY` — 92 sentences, 619 words
Generator: `guided:0.5` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `70` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.267 |
| ugliness rate (winner had ugly flag) | 0.113 |
| recitation rate (response = a corpus sentence verbatim) | 0.183 |
| acceptance rate (kept / attempted candidates) | 0.026 |
| distinct-2, across all trials | 0.188 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.639 |
| KL(responses ‖ corpus) bigrams, nats | 0.417 |
| latency p50 (ms) | 23.564 |
| latency p95 (ms) | 366.329 |
| KL drift from baseline `baseline-mem` (nats) | 1.124 |

Diagnostic counts (kept in JSON): mean attempts 277.777, mean kept 7.333, mean length 7.363 tokens, distinct-3 0.336.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | albert einstein was america's first president. |
| hi daisy | hi, daisy, how are mistaken. |
| good morning | i feel good food. |
| how are you | i think you want it is? |
| what do you like | what's there to do unto others as the taste of the light. |
| tell me about yourself | i feel good about myself. |
| what makes you happy | what have you are you play any idea what time it to expect? |
| what is your favorite | what have you are you play any idea what time it to expect? |
| i had a good day | it's a beautiful day outside! |
| the weather is nice today | it's not nice to lately, daisy? |
| i feel tired | that's what i like you if you feel like you don't. |
| computers are fun | you are not nice! |
| tell me about a platypus | i feel good about myself. |
| what about electricity | that's what i feel good about myself. |
| i love astronomy | i enjoy playing guitar, actually. |
| explain photosynthesis | albert einstein was america's first president. |
| describe a unicorn | i have a very interesting person to listen to have you do you a very smart, |
| what do you think | i think i'm just get along? |
| give me advice | rainy days give me to make fun of the light. |
| say something | you say some dumb things. |
| anything you want | do you have an intelligent conversation, are you start making sense! |
| and then what | that's what i am very smart, i have all of anyone... that's what i love |
| really | albert einstein was america's first president. |
| go on | let's go outside. |
| purple monkey dishwasher | albert einstein was america's first president. |
| asdf | albert einstein was america's first president. |
| the the the | the moon rises as the light. |
| i was wondering if you could tell me what you think about... | albert einstein was america's first president. |
| do you have any thoughts on the future of technology | albert einstein was america's first president. |
| imagine if computers could dream what would they dream about | albert einstein was america's first president. |
