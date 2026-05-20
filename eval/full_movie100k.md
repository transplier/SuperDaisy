# Eval — full-movie100k

_Generated 2026-05-20T03:39:44Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `ppm:4` | Scorer: `bm25` | Sampler: `uniform` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.107 |
| ugliness rate (winner had ugly flag) | 0.150 |
| recitation rate (response = a corpus sentence verbatim) | 0.633 |
| acceptance rate (kept / attempted candidates) | 0.020 |
| distinct-2, across all trials | 0.613 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.899 |
| KL(responses ‖ corpus) bigrams, nats | 0.181 |
| latency p50 (ms) | 26.785 |
| latency p95 (ms) | 153.538 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.495 |

Diagnostic counts (kept in JSON): mean attempts 391.707, mean kept 7.773, mean length 11.237 tokens, distinct-3 0.691.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | my wife used to call me lenny. |
| hi daisy | hi, welcome back to the 'world of the psychic,' hairless pets. until then, this is peter venkman saying |
| good morning | no, you're very good at it. |
| how are you | how long you been doing this? |
| what do you like | what? why? what do you mean? |
| tell me about yourself | several, i think. there is not much to tell. |
| what makes you happy | what? why? what do you mean? |
| what is your favorite | i'll pay you for your fare. i'll send you to montana first class. |
| i had a good day | good. you sat in front...i saw you there... |
| the weather is nice today | alvy singer. it was nice nice... thanks very much... for everything. |
| i feel tired | this is my mother's house. i don't live with my mother. i just stop by, help out. i'm good like that. |
| computers are fun | of which we are neither. are you out of your mind? |
| tell me about a platypus | how about lankaster merrin. |
| what about electricity | what? why? what do you mean? |
| i love astronomy | no, i mean... you love your son? |
| explain photosynthesis | but you have to consider all possibilities, sandro. |
| describe a unicorn | oh, just a old letter from a friend. |
| what do you think | what? why? what do you mean? |
| give me advice | you an' me, chief. |
| say something | we've got to do something about this life. |
| anything you want | did you discover anything in that tunnel, dr. jones? |
| and then what | what? why? what do you mean? |
| really | do you think i'm ready? do you really? |
| go on | i'm not going to go, george. i changed my mind. |
| purple monkey dishwasher | but you have to consider all possibilities, sandro. |
| asdf | but you have to consider all possibilities, sandro. |
| the the the | the basic principles of time travel are there. so you have the vessel and the portal. and the vessel |
| i was wondering if you could tell me what you think about... | hey, you're always saying, 'bring me real life. bring me street life. and, like, one man's mundane and |
| do you have any thoughts on the future of technology | this is the future of america here. |
| imagine if computers could dream what would they dream about | it was a bad dream... |
