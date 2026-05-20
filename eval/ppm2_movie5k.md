# Eval — ppm2-movie5k

_Generated 2026-05-20T05:21:07Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `ppm:2` | Scorer: `classic` | Sampler: `uniform` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.430 |
| ugliness rate (winner had ugly flag) | 0.217 |
| recitation rate (response = a corpus sentence verbatim) | 0.187 |
| acceptance rate (kept / attempted candidates) | 0.005 |
| distinct-2, across all trials | 0.478 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.923 |
| KL(responses ‖ corpus) bigrams, nats | 0.203 |
| latency p50 (ms) | 79.440 |
| latency p95 (ms) | 233.970 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.718 |

Diagnostic counts (kept in JSON): mean attempts 820.447, mean kept 3.807, mean length 11.757 tokens, distinct-3 0.528.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | who's to say hello. |
| hi daisy | no thanks, i needed that. |
| good morning | thank you. i been in the morning when the feeders came. |
| how are you | how long you been up to? |
| what do you like | i'm still better than squeezing into my affairs like that! |
| tell me about yourself | you take care of yourself, okay? |
| what makes you happy | the happy hunting ground. who cares? |
| what is your favorite | who's your favorite basketball player? |
| i had a good day | hullo, sam. slow day? |
| the weather is nice today | no thanks, i needed that. |
| i feel tired | i don't see any reason to come up to kidnapping, you should know, i'm very tired all of the good people. |
| computers are fun | better than cousteau, or compagno with computers, telemetry, defense department funding... |
| tell me about a platypus | no thanks, i needed that. |
| what about electricity | no thanks, i needed that. |
| i love astronomy | no thanks, i needed that. |
| explain photosynthesis | no thanks, i needed that. |
| describe a unicorn | no thanks, i needed that. |
| what do you think | i thought you were just shy, but now i think if she has transcended her conditioning. i think she knows. |
| give me advice | no thanks, i needed that. |
| say something | good of you point a gun and bring back something here. yeah. |
| anything you want | i would never miss anything that cannot be programmed, categorized or easily referenced... |
| and then what | and then what? then you'll start singin' beach boy songs again. then i'll really get depressed. |
| really | i dont care who he is, i really do grow old. before you really are. |
| go on | maybe you're the most expeditious manner and i think i'd better go. |
| purple monkey dishwasher | no thanks, i needed that. |
| asdf | no thanks, i needed that. |
| the the the | well, my wife, ester's down the stairs and undressing in the forgotten languages of my life over some |
| i was wondering if you could tell me what you think about... | no thanks, i needed that. |
| do you have any thoughts on the future of technology | no thanks, i needed that. |
| imagine if computers could dream what would they dream about | better than cousteau, or compagno with computers, telemetry, defense department funding... |
