# Eval — ppm-movie5k

_Generated 2026-05-20T03:19:48Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `ppm:4` | Scorer: `classic` | Sampler: `uniform` | Seed: `uniform` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.447 |
| ugliness rate (winner had ugly flag) | 0.070 |
| recitation rate (response = a corpus sentence verbatim) | 0.730 |
| acceptance rate (kept / attempted candidates) | 0.005 |
| distinct-2, across all trials | 0.441 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.846 |
| KL(responses ‖ corpus) bigrams, nats | 0.195 |
| latency p50 (ms) | 69.640 |
| latency p95 (ms) | 127.616 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.725 |

Diagnostic counts (kept in JSON): mean attempts 825.237, mean kept 3.750, mean length 9.963 tokens, distinct-3 0.486.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | i just had to come down and say hello. |
| hi daisy | well, that's what i said, isn't it? |
| good morning | fuck, man. too early in the morning for that, you know what i mean. |
| how are you | you sure that's how you spell it? |
| what do you like | sorry, sweetheart. bein' in love with you like i am brings out that ugly jealous side. |
| tell me about yourself | ha ha ha! you burned yourself to death by lighting the fart! ha ha ha!! |
| what makes you happy | but they only think they're happy. |
| what is your favorite | well, that's what i said, isn't it? |
| i had a good day | what did it matter if fedex was five minutes late one day? the next day we just start over again. |
| the weather is nice today | well, that's what i said, isn't it? |
| i feel tired | geez, he never gets tired does he. |
| computers are fun | better than cousteau, or compagno with computers, telemetry, defense department funding... |
| tell me about a platypus | well, that's what i said, isn't it? |
| what about electricity | well, that's what i said, isn't it? |
| i love astronomy | well, that's what i said, isn't it? |
| explain photosynthesis | well, that's what i said, isn't it? |
| describe a unicorn | well, that's what i said, isn't it? |
| what do you think | in whatever way you think i mean. |
| give me advice | i really don't think i need any social advice from you right now. |
| say something | not just yet, baby. there's...there's something daddy has to do. |
| anything you want | "he kicks up at anything he hears. |
| and then what | but i think it's swell. and then you come along... and... and then i'm a member of the hairy mole club, |
| really | i really don't think i need any social advice from you right now. |
| go on | loew didn't go with him. |
| purple monkey dishwasher | well, that's what i said, isn't it? |
| asdf | well, that's what i said, isn't it? |
| the the the | the basic principles of time travel are there. so you have the vessel and the portal. and the vessel |
| i was wondering if you could tell me what you think about... | well, that's what i said, isn't it? |
| do you have any thoughts on the future of technology | well, that's what i said, isn't it? |
| imagine if computers could dream what would they dream about | better than cousteau, or compagno with computers, telemetry, defense department funding... |
