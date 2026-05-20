# Eval — bm25seed-guided1_0-movie100k

_Generated 2026-05-20T05:24:48Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `guided:1.0` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.077 |
| ugliness rate (winner had ugly flag) | 0.220 |
| recitation rate (response = a corpus sentence verbatim) | 0.007 |
| acceptance rate (kept / attempted candidates) | 0.121 |
| distinct-2, across all trials | 0.785 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.917 |
| KL(responses ‖ corpus) bigrams, nats | 0.174 |
| latency p50 (ms) | 509.173 |
| latency p95 (ms) | 551.169 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.397 |

Diagnostic counts (kept in JSON): mean attempts 58.273, mean kept 7.040, mean length 12.063 tokens, distinct-3 0.947.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello walter. i think, but i recognize you... i knew a townhouse on re-opening the mark. |
| hi daisy | yes... hi sarris... how long they just talking. |
| good morning | good ... good student, but you're gonna throw bronco nagurski, that's when i just go. i've never walked |
| how are you | do you want to grissom. request you don't really like were you, everything's okay, i'm just, i heard |
| what do you like | what do you get a sudden impulses which you do was really got kids, im going to be i think it's ours. |
| tell me about yourself | tell me, 007, what about anybody else tell me into it, dave? |
| what makes you happy | what do you know what is where are you could've at this high. wouldn't believe a man will you don't |
| what is your favorite | industrial espionage is so where is both cruel, and that's a string along in medicine. are not so miss |
| i had a good day | i am. i'm here this day, sir. if you and i can be quicker than i was beautiful when you expect the day |
| the weather is nice today | let nice guy now? |
| i feel tired | i'm going, leon... but i thought maybe you feel on that why? |
| computers are fun | good thinking, dwight. traumatized co-eds are people are you? |
| tell me about a platypus | tell her i'm the gun. |
| what about electricity | what about mrs. clifton. |
| i love astronomy | i know. i'm afraid not. long ago about this, but i might be soft?". |
| explain photosynthesis | explain to me straight: did you don't hold it details to the possible purpose behind new satan. |
| describe a unicorn | ready. a museum in the way i think so. |
| what do you think | you think jerry has his aunt em out? she's completely of redoing the spider? |
| give me advice | just give me here soon. |
| say something | say matt, you doin that? |
| anything you want | hey, you did you like sunken ships, man. do you feel our house. |
| and then what | what was he is always thought that one day you got tired for the pile up to the hidden agenda? |
| really | you really have you trouble? |
| go on | better go on me. |
| purple monkey dishwasher | he asked me know dean martin... |
| asdf | then put him dead and feast on it. |
| the the the | hallo, this is like the only for god's sake, who the forest ... is never believe me. |
| i was wondering if you could tell me what you think about... | she's wondering what's been prevented. that swann's idea? |
| do you have any thoughts on the future of technology | guilty thoughts. see the cat has been back on. |
| imagine if computers could dream what would they dream about | can you imagine a doll. but what he blames you can i see why. |
