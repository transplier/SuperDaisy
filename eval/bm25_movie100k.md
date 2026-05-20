# Eval — bm25-movie100k

_Generated 2026-05-20T03:19:40Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `classic` | Scorer: `bm25` | Sampler: `uniform` | Seed: `uniform` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.090 |
| ugliness rate (winner had ugly flag) | 0.177 |
| recitation rate (response = a corpus sentence verbatim) | 0.013 |
| acceptance rate (kept / attempted candidates) | 0.020 |
| distinct-2, across all trials | 0.667 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.959 |
| KL(responses ‖ corpus) bigrams, nats | 0.179 |
| latency p50 (ms) | 19.092 |
| latency p95 (ms) | 64.913 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.348 |

Diagnostic counts (kept in JSON): mean attempts 385.873, mean kept 7.827, mean length 12.433 tokens, distinct-3 0.763.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | i'ma be in you, nick mason. you're our inside my house and when i say hello. |
| hi daisy | what?... oh yes... hi sarris... how did your mother engaged to a complete fruit-loop or die this second |
| good morning | where's the air tight. there've been waiting for this isn't just some good blow, right? |
| how are you | you should have no idea what do you mean? |
| what do you like | you should have no idea what do you mean? |
| tell me about yourself | yep. right about your line. |
| what makes you happy | when do you ought to be here. what are you? do you what i know, bienstock, there's something you'd like to |
| what is your favorite | but they only question left is: who gets to one. |
| i had a good day | i want you might want some day. ouch! |
| the weather is nice today | this is... really believe your life is good. it nice. |
| i feel tired | if he didn't have the olives, and i, i gotta figure some ted carson. |
| computers are fun | you are asking about our availability. like he wants to take me very carefully, benjamin. you are not |
| tell me about a platypus | i've read scripts about detectives, but i'm okay. |
| what about electricity | when do you ought to be here. what are you? do you what i know, bienstock, there's something you'd like to |
| i love astronomy | if he didn't have the olives, and i, i gotta figure some ted carson. |
| explain photosynthesis | well, why didn't have to explain why someone would you hurt him...?! answer me. |
| describe a unicorn | ...is this a yale education... and took a meeting with mr. zimm. |
| what do you think | you should have no idea what do you mean? |
| give me advice | then give me starts out in tarzana. |
| say something | the more you gonna say? exactly as if there were a lot of promises. |
| anything you want | you should have no idea what do you mean? |
| and then what | show me mugshots of mexican policemen. maybe then we'll go down the misses. get those crates overboard. what |
| really | this is... really believe your life is good. it nice. |
| go on | can we go smooth. |
| purple monkey dishwasher | i'm not positive... but... he knows. |
| asdf | i'm not positive... but... he knows. |
| the the the | no. not at the airport. i'll bring the wine, you bring the break-ins, the enemies closer. isn't that |
| i was wondering if you could tell me what you think about... | this is... really believe your life is good. it nice. |
| do you have any thoughts on the future of technology | you disappeared on our tails. my future? |
| imagine if computers could dream what would they dream about | don't be in a dream she comes, stays, lays or prays. whatever the fuck i do for you, bob? |
