# Eval — ppm-movie100k

_Generated 2026-05-20T03:39:49Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `ppm:4` | Scorer: `classic` | Sampler: `uniform` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.490 |
| ugliness rate (winner had ugly flag) | 0.173 |
| recitation rate (response = a corpus sentence verbatim) | 0.683 |
| acceptance rate (kept / attempted candidates) | 0.004 |
| distinct-2, across all trials | 0.441 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.930 |
| KL(responses ‖ corpus) bigrams, nats | 0.217 |
| latency p50 (ms) | 72.266 |
| latency p95 (ms) | 146.908 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.796 |

Diagnostic counts (kept in JSON): mean attempts 822.477, mean kept 3.673, mean length 10.760 tokens, distinct-3 0.483.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | it changed. why? okay, back over your wrist. because and here is the principle of tiny variations - |
| hi daisy | but you have to consider all possibilities, sandro. |
| good morning | and that means earl williams dies tomorrow morning and makes a sucker out of us! |
| how are you | how many... how many people are missing? |
| what do you like | but these, like, white supremacists trashed my office, last week. |
| tell me about yourself | you should look like you dressed yourself. |
| what makes you happy | what makes you interesting. as a teacher. |
| what is your favorite | but you have to consider all possibilities, sandro. |
| i had a good day | amen to that. it's been a crazy day, hasn't it?! |
| the weather is nice today | i have a right to ask you to be a little under the weather this morning. |
| i feel tired | leave me, now sir, i am tired. |
| computers are fun | but you have to consider all possibilities, sandro. |
| tell me about a platypus | but you have to consider all possibilities, sandro. |
| what about electricity | but you have to consider all possibilities, sandro. |
| i love astronomy | but you have to consider all possibilities, sandro. |
| explain photosynthesis | but you have to consider all possibilities, sandro. |
| describe a unicorn | but you have to consider all possibilities, sandro. |
| what do you think | well if you could tell me it was okay. i think that was the first time. |
| give me advice | but you have to consider all possibilities, sandro. |
| say something | all i ever do is play. i should be doing something to get my own shop open. |
| anything you want | is anything wrong? you look a little shaken up. |
| and then what | let's go look, then. let's go look, then! |
| really | do you think i'm ready? do you really? |
| go on | let's go and muck in. |
| purple monkey dishwasher | but you have to consider all possibilities, sandro. |
| asdf | but you have to consider all possibilities, sandro. |
| the the the | the basic principles of time travel are there. so you have the vessel and the portal. and the vessel |
| i was wondering if you could tell me what you think about... | but you have to consider all possibilities, sandro. |
| do you have any thoughts on the future of technology | but you have to consider all possibilities, sandro. |
| imagine if computers could dream what would they dream about | but you have to consider all possibilities, sandro. |
