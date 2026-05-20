# Eval — bm25t05-movie100k

_Generated 2026-05-20T05:23:10Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `classic` | Scorer: `bm25` | Sampler: `temperature:0.5` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.373 |
| ugliness rate (winner had ugly flag) | 0.247 |
| recitation rate (response = a corpus sentence verbatim) | 0.007 |
| acceptance rate (kept / attempted candidates) | 0.111 |
| distinct-2, across all trials | 0.507 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.976 |
| KL(responses ‖ corpus) bigrams, nats | 0.188 |
| latency p50 (ms) | 524.801 |
| latency p95 (ms) | 601.983 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.564 |

Diagnostic counts (kept in JSON): mean attempts 27.117, mean kept 3.000, mean length 12.200 tokens, distinct-3 0.564.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | ted, shut up. right? |
| hi daisy | oh... i guess the dozer musta been a grand old place at the end of hours. |
| good morning | he's getting my hotel room. you or that pretty good assumption. |
| how are you | well? you have something to do you care? |
| what do you like | they seem to do something for weeks, mom. it's a good idea? seriously? |
| tell me about yourself | okay. why don't worry about reading for hours. |
| what makes you happy | the ship... out the beard. mutual interests. they been perfect. |
| what is your favorite | but i think sex is so many? |
| i had a good day | he's getting my hotel room. you or that pretty good assumption. |
| the weather is nice today | wise one, the last drop, if we're ins... |
| i feel tired | but i think sex is so many? |
| computers are fun | where are we, you ask, survive without whistler's mother would like that. |
| tell me about a platypus | okay. why don't worry about reading for hours. |
| what about electricity | you will remember what freud said: "follow the raven in her flight...". |
| i love astronomy | i don't let him buy a lot of respect for parents breaks down, that's bad...you know i'm "cumpari" with them...so i |
| explain photosynthesis | marietta, i was turned in, she can bring kross back information? |
| describe a unicorn | i just lost a lot of a cockapoo lookin' at? you lookin' like ronald reagan here. |
| what do you think | what do you want to be nervous around me, you fucker! |
| give me advice | what do you want to be nervous around me, you fucker! |
| say something | i didn't say it? say it now sir. |
| anything you want | what do you want to be nervous around me, you fucker! |
| and then what | "what about you? like a moth and the flame. |
| really | it is really felt able to save the world. |
| go on | will you go to new york. |
| purple monkey dishwasher | i saw you locked your door. |
| asdf | that was three thousand dollars. that's what we're here since noon. i told teddy about it right now. |
| the the the | the ship... out the beard. mutual interests. they been perfect. |
| i was wondering if you could tell me what you think about... | that was three thousand dollars. that's what we're here since noon. i told teddy about it right now. |
| do you have any thoughts on the future of technology | that was three thousand dollars. that's what we're here since noon. i told teddy about it right now. |
| imagine if computers could dream what would they dream about | i saw you locked your door. |
