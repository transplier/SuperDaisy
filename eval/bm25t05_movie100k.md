# Eval — bm25t05-movie100k

_Generated 2026-05-20T04:17:39Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `classic` | Scorer: `bm25` | Sampler: `temperature:0.5` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.337 |
| ugliness rate (winner had ugly flag) | 0.287 |
| recitation rate (response = a corpus sentence verbatim) | 0.003 |
| acceptance rate (kept / attempted candidates) | 0.112 |
| distinct-2, across all trials | 0.499 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.977 |
| KL(responses ‖ corpus) bigrams, nats | 0.190 |
| latency p50 (ms) | 518.121 |
| latency p95 (ms) | 582.576 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.572 |

Diagnostic counts (kept in JSON): mean attempts 32.830, mean kept 3.670, mean length 12.197 tokens, distinct-3 0.555.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | adam, that's not true. we checked them in. |
| hi daisy | oh... i guess the dozer musta been a grand old place at the end of hours. |
| good morning | he's getting my hotel room. you or that pretty good assumption. |
| how are you | where are we, you ask, survive without whistler's mother would like that. |
| what do you like | what do you want to be nervous around me, you fucker! |
| tell me about yourself | okay. why don't worry about reading for hours. |
| what makes you happy | "what about you? like a moth and the flame. |
| what is your favorite | i saw you locked your door. |
| i had a good day | he's getting my hotel room. you or that pretty good assumption. |
| the weather is nice today | like how weirded-out you are with us... |
| i feel tired | i don't let him buy a lot of respect for parents breaks down, that's bad...you know i'm "cumpari" with them...so i |
| computers are fun | where are we, you ask, survive without whistler's mother would like that. |
| tell me about a platypus | "what about you? like a moth and the flame. |
| what about electricity | "what about you? like a moth and the flame. |
| i love astronomy | i don't let him buy a lot of respect for parents breaks down, that's bad...you know i'm "cumpari" with them...so i |
| explain photosynthesis | like how weirded-out you are with us... |
| describe a unicorn | i just lost a lot of a cockapoo lookin' at? you lookin' like ronald reagan here. |
| what do you think | what do you want to be nervous around me, you fucker! |
| give me advice | what do you want to be nervous around me, you fucker! |
| say something | i didn't say it? say it now sir. |
| anything you want | what do you want to be nervous around me, you fucker! |
| and then what | "what about you? like a moth and the flame. |
| really | it is really felt able to save the world. |
| go on | will you go to new york. |
| purple monkey dishwasher | teddy, i thought you wouldn't want them hurt. any calls made to ask you, as amy told me that you can't |
| asdf | teddy, i thought you wouldn't want them hurt. any calls made to ask you, as amy told me that you can't |
| the the the | the ship... out the beard. mutual interests. they been perfect. |
| i was wondering if you could tell me what you think about... | teddy, i thought you wouldn't want them hurt. any calls made to ask you, as amy told me that you can't |
| do you have any thoughts on the future of technology | teddy, i thought you wouldn't want them hurt. any calls made to ask you, as amy told me that you can't |
| imagine if computers could dream what would they dream about | teddy, i thought you wouldn't want them hurt. any calls made to ask you, as amy told me that you can't |
