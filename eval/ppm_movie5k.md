# Eval — ppm-movie5k

_Generated 2026-05-19T22:57:49Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 507 sentences, 5005 words
Generator: `ppm:4` | Scorer: `classic` | max_length: `77` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.473 |
| ugliness rate (winner had ugly flag) | 0.180 |
| recitation rate (response = a corpus sentence verbatim) | 0.790 |
| acceptance rate (kept / attempted candidates) | 0.005 |
| distinct-2, across all trials | 0.244 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.676 |
| KL(responses ‖ corpus) bigrams, nats | 0.418 |
| latency p50 (ms) | 34.436 |
| latency p95 (ms) | 36.435 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.911 |

Diagnostic counts (kept in JSON): mean attempts 843.553, mean kept 3.803, mean length 8.423 tokens, distinct-3 0.264.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, sir. it's david. |
| hi daisy | he's a good man. |
| good morning | i picked up my ticket. i'm leaving in the morning, jez. |
| how are you | how close do you have to be? |
| what do you like | you don't like the way things are, i don't like the way things. |
| tell me about yourself | i seem to remember that you like to help yourself. |
| what makes you happy | but you don't look very happy. |
| what is your favorite | he's a good man. |
| i had a good day | well you don't drive around from midnight until noon the next day, benjamin. |
| the weather is nice today | he's a good man. |
| i feel tired | miss gibson, i'm tired of resting. |
| computers are fun | he's a good man. |
| tell me about a platypus | he's a good man. |
| what about electricity | he's a good man. |
| i love astronomy | he's a good man. |
| explain photosynthesis | he's a good man. |
| describe a unicorn | he's a good man. |
| what do you think | do you think he would like a raise and a new position ? |
| give me advice | i really don't think i need any social advice from you right now. |
| say something | no, it grosses me out even thinking of putting something in my eye. |
| anything you want | never say anything unless you have to. |
| and then what | then what is he? |
| really | really? what are they like? |
| go on | does that still go? |
| purple monkey dishwasher | he's a good man. |
| asdf | he's a good man. |
| the the the | dennis won't let me go to the desk. he makes me sit on the floor. |
| i was wondering if you could tell me what you think about... | he's a good man. |
| do you have any thoughts on the future of technology | he's a good man. |
| imagine if computers could dream what would they dream about | he's a good man. |
