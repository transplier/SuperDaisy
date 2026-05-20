# Eval — bm25seed-guided1_0-movie100k

_Generated 2026-05-20T05:42:23Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `guided:1.0` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.197 |
| recitation rate (response = a corpus sentence verbatim) | 0.010 |
| acceptance rate (kept / attempted candidates) | 0.096 |
| distinct-2, across all trials | 0.780 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.905 |
| KL(responses ‖ corpus) bigrams, nats | 0.175 |
| latency p50 (ms) | 872.561 |
| latency p95 (ms) | 2192.082 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.408 |

Diagnostic counts (kept in JSON): mean attempts 97.093, mean kept 9.317, mean length 11.673 tokens, distinct-3 0.941.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, thomas... i'm going to be a little link, between a whole thing is for a mistake. |
| hi daisy | yes... hi sarris... how long they just talking. |
| good morning | good ... good student, but you're gonna throw bronco nagurski, that's when i just go. i've never walked |
| how are you | do you want to grissom. request you don't really like were you, everything's okay, i'm just, i heard |
| what do you like | what do you get a sudden impulses which you do was really got kids, im going to be i think it's ours. |
| tell me about yourself | tell me, 007, what about anybody else tell me into it, dave? |
| what makes you happy | what do you know what is where are you could've at this high. wouldn't believe a man will you don't |
| what is your favorite | your husband is your family got a great tonight. i didn't do you think of him. |
| i had a good day | i am. i'm here this day, sir. if you and i can be quicker than i was beautiful when you expect the day |
| the weather is nice today | you got nice thing he wins, i mentioned savage henry friggin' tape. |
| i feel tired | i'm going, leon... but i thought maybe you feel on that why? |
| computers are fun | good thinking, dwight. traumatized co-eds are people are you? |
| tell me about a platypus | tell me about the gun when you're too stupid not your heart to maranzano, that where would have the |
| what about electricity | what about mrs. clifton. |
| i love astronomy | i know. i'm afraid not. long ago about this, but i might be soft?". |
| explain photosynthesis | explain to me about some sleep, baby. |
| describe a unicorn | ready. a museum in the way i think so. |
| what do you think | you think jerry has his aunt em out? she's completely of redoing the spider? |
| give me advice | just give me here soon. |
| say something | say matt, you doin that? |
| anything you want | hey, you did you like sunken ships, man. do you feel our house. |
| and then what | keep my terms and i front a whole day. and what happened to hear. 'cause you weren't, ergo, i take things |
| really | you really have you trouble? |
| go on | better go on me. |
| purple monkey dishwasher | he asked me a long as a nigger, you're an institution. |
| asdf | i need your life, a drink from the quadrant. |
| the the the | hallo, this is like the only for god's sake, who the forest ... is never believe me. |
| i was wondering if you could tell me what you think about... | i've been meaning to change. |
| do you have any thoughts on the future of technology | guilty thoughts. see the brain surgeon. |
| imagine if computers could dream what would they dream about | can you imagine my parents breaks down, mr. connell, 'cause you don't see you just right. |
