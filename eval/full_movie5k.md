# Eval — full-movie5k

_Generated 2026-05-20T04:15:19Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `ppm:4` | Scorer: `bm25` | Sampler: `uniform` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.097 |
| ugliness rate (winner had ugly flag) | 0.167 |
| recitation rate (response = a corpus sentence verbatim) | 0.673 |
| acceptance rate (kept / attempted candidates) | 0.020 |
| distinct-2, across all trials | 0.577 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.856 |
| KL(responses ‖ corpus) bigrams, nats | 0.150 |
| latency p50 (ms) | 25.131 |
| latency p95 (ms) | 93.162 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.478 |

Diagnostic counts (kept in JSON): mean attempts 392.553, mean kept 7.903, mean length 11.507 tokens, distinct-3 0.649.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | i just had to come down and say hello. |
| hi daisy | well, that's what i said, isn't it? |
| good morning | this is good. it is a good story, fish. |
| how are you | the basic principles of time travel are there. so you have the vessel and the portal. and the vessel |
| what do you like | what? why? what do you mean? |
| tell me about yourself | they can tell from the eyelashes, you know? |
| what makes you happy | what? why? what do you mean? |
| what is your favorite | for the sake of your argument, let us say that is correct. |
| i had a good day | this is good. it is a good story, fish. |
| the weather is nice today | alvy singer. it was nice nice... thanks very much... for everything. |
| i feel tired | i have this ... feeling. i'm not sure, really ... |
| computers are fun | of which we are neither. are you out of your mind? |
| tell me about a platypus | they can tell from the eyelashes, you know? |
| what about electricity | what about mrs. moebius and...? |
| i love astronomy | no, i mean... you love your son? |
| explain photosynthesis | well, that's what i said, isn't it? |
| describe a unicorn | oh, just a old letter from a friend. |
| what do you think | what? why? what do you mean? |
| give me advice | dear me, you'll be telling me to watch what i eat next. |
| say something | what do you say we go out to dinner tonight, catch up on old times? |
| anything you want | stop calling it the property, you sound ridiculous. |
| and then what | what? why? what do you mean? |
| really | i really don't think i need any social advice from you right now. |
| go on | we're makin' moves on each other. |
| purple monkey dishwasher | well, that's what i said, isn't it? |
| asdf | well, that's what i said, isn't it? |
| the the the | the basic principles of time travel are there. so you have the vessel and the portal. and the vessel |
| i was wondering if you could tell me what you think about... | hey, you're always saying, 'bring me real life. bring me street life. and, like, one man's mundane and |
| do you have any thoughts on the future of technology | precisely. what's on all our minds? brainwaves. the future of wayne enterprises is brainwaves! |
| imagine if computers could dream what would they dream about | better than cousteau, or compagno with computers, telemetry, defense department funding... |
