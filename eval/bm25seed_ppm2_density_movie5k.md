# Eval — bm25seed-ppm2-density-movie5k

_Generated 2026-05-20T03:39:36Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `ppm:2` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `density` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.053 |
| recitation rate (response = a corpus sentence verbatim) | 0.350 |
| acceptance rate (kept / attempted candidates) | 0.105 |
| distinct-2, across all trials | 0.627 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.780 |
| KL(responses ‖ corpus) bigrams, nats | 0.158 |
| latency p50 (ms) | 18.190 |
| latency p95 (ms) | 112.413 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.510 |

Diagnostic counts (kept in JSON): mean attempts 88.683, mean kept 9.303, mean length 5.580 tokens, distinct-3 0.696.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello walter. i want in the street, whatever, you're fucked. you need to rest mr. parker... it's for |
| hi daisy | hi, dick. i'm alabama worley. |
| good morning | well, congratulations! good luck! |
| how are you | and god love you so suspicious? |
| what do you like | what is it so long. |
| tell me about yourself | dad, i'm about to finish last. |
| what makes you happy | what are you doing?! |
| what is your favorite | your hand is bleeding. |
| i had a good day | sounds good - thank you. |
| the weather is nice today | it's a nice restaurants. |
| i feel tired | well, i got it. |
| computers are fun | are you all right? |
| tell me about a platypus | what about the ghosts... |
| what about electricity | i'm real upset about what happened? |
| i love astronomy | i said nobody dies. |
| explain photosynthesis | explain to me now. |
| describe a unicorn | it's full a money. |
| what do you think | a reward for what? |
| give me advice | what's happening to me? |
| say something | you're really something, ace. |
| anything you want | you on any medication? |
| and then what | chair, cup and ball. |
| really | oh really? that's great. |
| go on | way to go, mom! |
| purple monkey dishwasher | no thanks, i needed that. |
| asdf | no thanks, i needed that. |
| the the the | what's the matter, hon? |
| i was wondering if you could tell me what you think about... | my life is your friend. |
| do you have any thoughts on the future of technology | the future, mr. gittes. |
| imagine if computers could dream what would they dream about | you know, my dream just now. |
