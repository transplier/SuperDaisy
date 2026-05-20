# Eval — bm25t05-movie100k

_Generated 2026-05-20T03:41:59Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `classic` | Scorer: `bm25` | Sampler: `temperature:0.5` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.330 |
| ugliness rate (winner had ugly flag) | 0.277 |
| recitation rate (response = a corpus sentence verbatim) | 0.003 |
| acceptance rate (kept / attempted candidates) | 0.112 |
| distinct-2, across all trials | 0.489 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.975 |
| KL(responses ‖ corpus) bigrams, nats | 0.192 |
| latency p50 (ms) | 517.929 |
| latency p95 (ms) | 555.130 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.579 |

Diagnostic counts (kept in JSON): mean attempts 32.930, mean kept 3.673, mean length 12.493 tokens, distinct-3 0.537.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | adam, that's not true. we checked them in. |
| hi daisy | stay the fuck someone tonight? |
| good morning | he's getting my hotel room. you or that pretty good assumption. |
| how are you | what do you want to be nervous around me, you fucker! |
| what do you like | what do you want to be nervous around me, you fucker! |
| tell me about yourself | okay. why don't worry about reading for hours. |
| what makes you happy | "what about you? like a moth and the flame. |
| what is your favorite | i saw you locked your door. |
| i had a good day | he's getting my hotel room. you or that pretty good assumption. |
| the weather is nice today | i saw you locked your door. |
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
| purple monkey dishwasher | like how weirded-out you are with us... |
| asdf | like how weirded-out you are with us... |
| the the the | the ship... out the beard. mutual interests. they been perfect. |
| i was wondering if you could tell me what you think about... | like how weirded-out you are with us... |
| do you have any thoughts on the future of technology | teddy, i thought you wouldn't want them hurt. any calls made to ask you, as amy told me that you can't |
| imagine if computers could dream what would they dream about | teddy, i thought you wouldn't want them hurt. any calls made to ask you, as amy told me that you can't |
