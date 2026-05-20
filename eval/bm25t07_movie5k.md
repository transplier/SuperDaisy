# Eval — bm25t07-movie5k

_Generated 2026-05-20T03:41:43Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `classic` | Scorer: `bm25` | Sampler: `temperature:0.7` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.277 |
| ugliness rate (winner had ugly flag) | 0.160 |
| recitation rate (response = a corpus sentence verbatim) | 0.033 |
| acceptance rate (kept / attempted candidates) | 0.096 |
| distinct-2, across all trials | 0.548 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.971 |
| KL(responses ‖ corpus) bigrams, nats | 0.155 |
| latency p50 (ms) | 508.789 |
| latency p95 (ms) | 538.577 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.501 |

Diagnostic counts (kept in JSON): mean attempts 48.397, mean kept 4.657, mean length 12.247 tokens, distinct-3 0.616.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | you can't hurt for a second. |
| hi daisy | when do you shouldn't have to the commissary to figure out, did you see this? |
| good morning | great. i'll have the guys to lie still. |
| how are you | when do you shouldn't have to the commissary to figure out, did you see this? |
| what do you like | yeah. they've been vampire, there has what you have. |
| tell me about yourself | no. i can tell you that. |
| what makes you happy | yeah? what about it. i think we can get it. you'll understand. |
| what is your favorite | ... whatever is your homework, larry. |
| i had a good day | don't use my life has had been beneath us a hundred and just die ! |
| the weather is nice today | he ain't eating beans fer lunch. |
| i feel tired | i didn't mean very bad. |
| computers are fun | where are we discussed? |
| tell me about a platypus | yeah? what about it. i think we can get it. you'll understand. |
| what about electricity | yeah? what about it. i think we can get it. you'll understand. |
| i love astronomy | i didn't mean very bad. |
| explain photosynthesis | explain to me it'll always be in here. |
| describe a unicorn | don't use my life has had been beneath us a hundred and just die ! |
| what do you think | yeah? what about it. i think we can get it. you'll understand. |
| give me advice | and if you better give me too. |
| say something | i don't think it's something else. |
| anything you want | when do you shouldn't have to the commissary to figure out, did you see this? |
| and then what | she probably went back and forth on it. |
| really | has this happened out there? why you're really here. |
| go on | she probably went back and forth on it. |
| purple monkey dishwasher | you wait here'n to take us? like you bus driver to dere? |
| asdf | you wait here'n to take us? like you bus driver to dere? |
| the the the | no. it's her i'm married, will see the arrest of the man all the way to the other side of the man's ethics, he's |
| i was wondering if you could tell me what you think about... | don't use my life has had been beneath us a hundred and just die ! |
| do you have any thoughts on the future of technology | it was the future. you can get my butt kicked for this. |
| imagine if computers could dream what would they dream about | poof! you're happy - you know, my dream has to double in fairvale ledgers! mrs. peel's black leather |
