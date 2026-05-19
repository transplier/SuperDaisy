# Eval — full-movie5k

_Generated 2026-05-19T22:46:43Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 507 sentences, 5005 words
Generator: `ppm:4` | Scorer: `bm25`
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.113 |
| ugliness rate (winner had ugly flag) | 0.180 |
| recitation rate (response = a corpus sentence verbatim) | 0.827 |
| acceptance rate (kept / attempted candidates) | 0.018 |
| distinct-2, across all trials | 0.374 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.641 |
| KL(responses ‖ corpus) bigrams, nats | 0.265 |
| latency p50 (ms) | 6.183 |
| latency p95 (ms) | 34.848 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.786 |

Diagnostic counts (kept in JSON): mean attempts 417.133, mean kept 7.513, mean length 9.470 tokens, distinct-3 0.411.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, sir. it's david. |
| hi daisy | hi, jerry. everything under control? |
| good morning | yes i do, and i think she's very good for your father. |
| how are you | i'm a professional. you guys are in my line of work. |
| what do you like | yes, do you think he would like a raise and a new position ? |
| tell me about yourself | don't you guys tell anybody about my plants. |
| what makes you happy | then what is he? |
| what is your favorite | is, uh... is he okay? |
| i had a good day | this is day care. its where babies go when their parents are at work. |
| the weather is nice today | are we done for today? |
| i feel tired | look, i can understand if you and foley are close. |
| computers are fun | david, david! what the hell are you doing!? |
| tell me about a platypus | don't you guys tell anybody about my plants. |
| what about electricity | what about your friends? or your brothers? when do i get to meet them? |
| i love astronomy | i'd love to. but aren't you supposed to meet up with simone? |
| explain photosynthesis | i sent for the police. we can explain. |
| describe a unicorn | yes, do you think he would like a raise and a new position ? |
| what do you think | yes, do you think he would like a raise and a new position ? |
| give me advice | dennis won't let me go to the desk. he makes me sit on the floor. |
| say something | say you're feeling faint - the sun. |
| anything you want | same as you. ten thousand. |
| and then what | then what is he? |
| really | really? what are they like? |
| go on | dennis won't let me go to the desk. he makes me sit on the floor. |
| purple monkey dishwasher | he's a good man. |
| asdf | he's a good man. |
| the the the | dennis won't let me go to the desk. he makes me sit on the floor. |
| i was wondering if you could tell me what you think about... | fuck you! have fun living with your dad for the rest of your life. it's |
| do you have any thoughts on the future of technology | a future. the only future i've got. |
| imagine if computers could dream what would they dream about | he's a good man. |
