# Eval — bm25t07-movie5k

_Generated 2026-05-20T03:21:44Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `classic` | Scorer: `bm25` | Sampler: `temperature:0.7` | Seed: `uniform` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.277 |
| ugliness rate (winner had ugly flag) | 0.177 |
| recitation rate (response = a corpus sentence verbatim) | 0.043 |
| acceptance rate (kept / attempted candidates) | 0.096 |
| distinct-2, across all trials | 0.551 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.968 |
| KL(responses ‖ corpus) bigrams, nats | 0.152 |
| latency p50 (ms) | 508.743 |
| latency p95 (ms) | 532.361 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.489 |

Diagnostic counts (kept in JSON): mean attempts 49.257, mean kept 4.723, mean length 12.303 tokens, distinct-3 0.622.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | frankie, come in. |
| hi daisy | she used those slave ships, man. |
| good morning | frankie, come in. |
| how are you | when do you shouldn't have to the commissary to figure out, did you see this? |
| what do you like | what did laura say? do you can't hurt people... |
| tell me about yourself | no. i can tell you that. |
| what makes you happy | yeah? what about it. i think we can get it. you'll understand. |
| what is your favorite | ... whatever is your homework, larry. |
| i had a good day | don't use my life has had been beneath us a hundred and just die ! |
| the weather is nice today | she probably went back and forth on it. |
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
| asdf | thanks, butt wart. you did good. |
| the the the | no. it's her i'm married, will see the arrest of the man all the way to the other side of the man's ethics, he's |
| i was wondering if you could tell me what you think about... | don't use my life has had been beneath us a hundred and just die ! |
| do you have any thoughts on the future of technology | it was the future. you can get my butt kicked for this. |
| imagine if computers could dream what would they dream about | poof! you're happy - you know, my dream has to double in fairvale ledgers! mrs. peel's black leather |
