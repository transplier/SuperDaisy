# Eval — baseline-movie5k

_Generated 2026-05-20T05:20:13Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `classic` | Scorer: `classic` | Sampler: `uniform` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.460 |
| ugliness rate (winner had ugly flag) | 0.080 |
| recitation rate (response = a corpus sentence verbatim) | 0.103 |
| acceptance rate (kept / attempted candidates) | 0.005 |
| distinct-2, across all trials | 0.577 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.962 |
| KL(responses ‖ corpus) bigrams, nats | 0.188 |
| latency p50 (ms) | 30.070 |
| latency p95 (ms) | 31.738 |

Diagnostic counts (kept in JSON): mean attempts 812.800, mean kept 3.773, mean length 9.697 tokens, distinct-3 0.656.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | i came down and say hello. |
| hi daisy | easy, there, mom. |
| good morning | i won't let me look, let me get this morning, either. |
| how are you | yeah, well when it does, morpheus will tell them for free in your head, or how about a second? |
| what do you like | no, that would you like your summer stock deal was, the car and scattered hannah all over town? |
| tell me about yourself | oh, dana, it's your dad. i don't think it was a bad yourself... |
| what makes you happy | i'm not that bad either but i'm borrowing it exactly that you come out of a happy zombie. |
| what is your favorite | who's your favorite picture. she was my place. |
| i had a good day | benedicite! what early springsteen, dude, this every day. |
| the weather is nice today | daddy'll do fine. what's the weather this morning. |
| i feel tired | i got tired does he. |
| computers are fun | always hoping. or london, paris or compagno with computers, telemetry, defense department funding... |
| tell me about a platypus | easy, there, mom. |
| what about electricity | easy, there, mom. |
| i love astronomy | easy, there, mom. |
| explain photosynthesis | easy, there, mom. |
| describe a unicorn | easy, there, mom. |
| what do you think | you don't think you'd better leave karen for you. |
| give me advice | easy, there, mom. |
| say something | i don't think there's something you'd know. |
| anything you want | who's to say anything? |
| and then what | then we'll have you ever talked to a corpse? it's boring! i'm building a case you're working on. |
| really | really? perhaps your wife. |
| go on | i'd better go to. he was human. |
| purple monkey dishwasher | easy, there, mom. |
| asdf | easy, there, mom. |
| the the the | looking for... the last drop, if another ship had to guess by now if that be all right? |
| i was wondering if you could tell me what you think about... | easy, there, mom. |
| do you have any thoughts on the future of technology | easy, there, mom. |
| imagine if computers could dream what would they dream about | always hoping. or london, paris or compagno with computers, telemetry, defense department funding... |
