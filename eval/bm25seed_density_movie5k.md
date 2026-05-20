# Eval — bm25seed-density-movie5k

_Generated 2026-05-20T03:39:36Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `classic` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `density` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.033 |
| recitation rate (response = a corpus sentence verbatim) | 0.080 |
| acceptance rate (kept / attempted candidates) | 0.099 |
| distinct-2, across all trials | 0.691 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.826 |
| KL(responses ‖ corpus) bigrams, nats | 0.153 |
| latency p50 (ms) | 19.802 |
| latency p95 (ms) | 58.078 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.383 |

Diagnostic counts (kept in JSON): mean attempts 94.633, mean kept 9.333, mean length 5.353 tokens, distinct-3 0.808.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello. so very much. here. |
| hi daisy | hi, it's me. |
| good morning | good job, not unless we're blind. |
| how are you | what are you do that, flynn? |
| what do you like | what do you take james that it? |
| tell me about yourself | what about the air! louise? talk about? |
| what makes you happy | what, some cheap, gruesome gags? |
| what is your favorite | yeah, she is. |
| i had a good day | we had a cop. |
| the weather is nice today | it isn't cheap. it's nice. |
| i feel tired | guess i always -. |
| computers are fun | are you okay? |
| tell me about a platypus | what about the same stuff herself. |
| what about electricity | what an odd question! |
| i love astronomy | i can't write it! |
| explain photosynthesis | explain to me home? |
| describe a unicorn | got a letter from a friend. |
| what do you think | what do i do, the answer it, or i'm sorry i said you had no idea. |
| give me advice | she scares me. |
| say something | okay to say why? |
| anything you want | hardly anything. i interact. |
| and then what | what are you and your son. |
| really | really? me, too! |
| go on | no, please go back! |
| purple monkey dishwasher | easy, there, mom. |
| asdf | easy, there, mom. |
| the the the | looking for... the countess. |
| i was wondering if you could tell me what you think about... | my whole life is your business. |
| do you have any thoughts on the future of technology | the future, mr. kringelein? |
| imagine if computers could dream what would they dream about | i can't imagine my surprise when they get fungus. |
