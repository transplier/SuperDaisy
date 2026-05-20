# Eval — baseline-movie100k

_Generated 2026-05-20T05:50:10Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `classic` | Scorer: `classic` | Sampler: `uniform` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.463 |
| ugliness rate (winner had ugly flag) | 0.090 |
| recitation rate (response = a corpus sentence verbatim) | 0.060 |
| acceptance rate (kept / attempted candidates) | 0.005 |
| distinct-2, across all trials | 0.541 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.974 |
| KL(responses ‖ corpus) bigrams, nats | 0.218 |
| latency p50 (ms) | 31.929 |
| latency p95 (ms) | 33.384 |

Diagnostic counts (kept in JSON): mean attempts 813.123, mean kept 3.747, mean length 10.793 tokens, distinct-3 0.609.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | i'ma be in you, nick mason. you're our inside my house and when i say hello. |
| hi daisy | i'm not positive... but... he knows. |
| good morning | we still don't believe in god rest her soul, it used to negotiate. what about me this morning? |
| how are you | how 'bout the coolest... then you come along... and... and then i'm sorry. forgive me. |
| what do you like | looks like pooch's doing okay. |
| tell me about yourself | yes noreen you know all about yourself. |
| what makes you happy | kinda makes you just slap me because of my instructions came directly through the heart. |
| what is your favorite | ugly... a couple of things. and my all-time favorite, the old standby, "i have to ask you, mrs... ummmm. |
| i had a good day | i'm not going to have a day to check it out? watch out!... why money? my name is blackmailing you? |
| the weather is nice today | i'm not positive... but... he knows. |
| i feel tired | i'm not positive... but... he knows. |
| computers are fun | i'm not positive... but... he knows. |
| tell me about a platypus | i'm not positive... but... he knows. |
| what about electricity | i'm not positive... but... he knows. |
| i love astronomy | i'm not positive... but... he knows. |
| explain photosynthesis | i'm not positive... but... he knows. |
| describe a unicorn | i'm not positive... but... he knows. |
| what do you think | what if i don't think so. |
| give me advice | i'm not positive... but... he knows. |
| say something | only in passing. i never thought you were going rate for saving you from something. |
| anything you want | i'd rather sing than do anything! |
| and then what | how 'bout the coolest... then you come along... and... and then i'm sorry. forgive me. |
| really | this is... really believe your life is good. it nice. |
| go on | has it ever go to the temperature of the object of the willpower. we just say it. |
| purple monkey dishwasher | i'm not positive... but... he knows. |
| asdf | i'm not positive... but... he knows. |
| the the the | no. not at the airport. i'll bring the wine, you bring the break-ins, the enemies closer. isn't that |
| i was wondering if you could tell me what you think about... | i'm not positive... but... he knows. |
| do you have any thoughts on the future of technology | i'm not positive... but... he knows. |
| imagine if computers could dream what would they dream about | i'm not positive... but... he knows. |
