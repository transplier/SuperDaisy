# Eval — bm25seed-ppm2-movie100k

_Generated 2026-05-20T05:50:39Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `ppm:2` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.063 |
| ugliness rate (winner had ugly flag) | 0.163 |
| recitation rate (response = a corpus sentence verbatim) | 0.150 |
| acceptance rate (kept / attempted candidates) | 0.102 |
| distinct-2, across all trials | 0.768 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.875 |
| KL(responses ‖ corpus) bigrams, nats | 0.184 |
| latency p50 (ms) | 18.317 |
| latency p95 (ms) | 86.283 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.429 |

Diagnostic counts (kept in JSON): mean attempts 91.300, mean kept 9.307, mean length 11.257 tokens, distinct-3 0.880.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello walter. i want and you don't know what i did. |
| hi daisy | hi, it's me. i'm a newspaper is something you might be just what is it? |
| good morning | so i see. slipping away for a few years back. good morning. |
| how are you | who are you? are you doing here? |
| what do you like | what do you know why i'm such a monstrous spectacle of yourself. |
| tell me about yourself | why? why didn't you tell me about it, of course. |
| what makes you happy | what did you bring them? |
| what is your favorite | focus all your posturing, all your posturing, all your memories too. you feel okay. |
| i had a good day | good job, not pretty, but good. |
| the weather is nice today | be nice. that thing ? you're braver than i got. |
| i feel tired | i was a bad idea, i just want to go into the game... |
| computers are fun | they are carrying guns. they are carrying guns. they are very interested in him. |
| tell me about a platypus | i've thought about you coming down from portland. |
| what about electricity | what are you saying that phrase over and take credit for this, you're crazy. |
| i love astronomy | i need this, roy. i can't say it. |
| explain photosynthesis | explain to me sooner. |
| describe a unicorn | not even a hunch. just hope. |
| what do you think | do what you did, unless... you didn't want to see you? quite frankly, he hates you. |
| give me advice | oh excuse me, sirshe sent me for real. make them call me don. |
| say something | we'll just say that all matters pertaining to this than you do. |
| anything you want | want to take an interest. you live next door, keep an eye on him, will you? |
| and then what | when you have now, and believe me, let's watch this or what?! |
| really | you're really doing a great tour. |
| go on | better go on back to czechoslovakia. |
| purple monkey dishwasher | he asked me to do a drug deal, you watch your tongue. |
| asdf | take a look for oil and stuff? |
| the the the | do you want the job names the price. if you like. |
| i was wondering if you could tell me what you think about... | my whole life has had any meaning, that's the crop, that must have tons of questions. |
| do you have any thoughts on the future of technology | the future, marty, the future of wayne enterprises is brainwaves! |
| imagine if computers could dream what would they dream about | better than cousteau, or compagno with computers, telemetry, defense department funding... |
