# Eval — ppm-movie100k

_Generated 2026-05-19T22:57:53Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 10313 sentences, 100008 words
Generator: `ppm:4` | Scorer: `classic` | max_length: `75` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.470 |
| ugliness rate (winner had ugly flag) | 0.130 |
| recitation rate (response = a corpus sentence verbatim) | 0.660 |
| acceptance rate (kept / attempted candidates) | 0.004 |
| distinct-2, across all trials | 0.467 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.929 |
| KL(responses ‖ corpus) bigrams, nats | 0.226 |
| latency p50 (ms) | 38.613 |
| latency p95 (ms) | 44.686 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.798 |

Diagnostic counts (kept in JSON): mean attempts 849.033, mean kept 3.543, mean length 8.950 tokens, distinct-3 0.511.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | just a half-a-cup. hello, dottie. i'm so sorry to hear of your troubles... |
| hi daisy | what are his qualifications besides being a white male and directing a hot new |
| good morning | then i expect you'll be leaving first thing in the morning. |
| how are you | but how did you get "kwan?" _ 82. |
| what do you like | it was like an internal struggle going on inside my body. |
| tell me about yourself | why give yourself up? |
| what makes you happy | hi, happy. well, you're obviously making him happy. |
| what is your favorite | are you hungry? what's your favorite food? we'll try to get it for you. |
| i had a good day | oh, it just came to me one day. |
| the weather is nice today | what are his qualifications besides being a white male and directing a hot new |
| i feel tired | what are his qualifications besides being a white male and directing a hot new |
| computers are fun | what are his qualifications besides being a white male and directing a hot new |
| tell me about a platypus | what are his qualifications besides being a white male and directing a hot new |
| what about electricity | what are his qualifications besides being a white male and directing a hot new |
| i love astronomy | what are his qualifications besides being a white male and directing a hot new |
| explain photosynthesis | what are his qualifications besides being a white male and directing a hot new |
| describe a unicorn | what are his qualifications besides being a white male and directing a hot new |
| what do you think | did he just say what i think he said? |
| give me advice | what are his qualifications besides being a white male and directing a hot new |
| say something | am i in trouble or something? |
| anything you want | well, anything coulda caused that. |
| and then what | ...then you rip my clothes off. then we rip lyndsey's clothes off. i think i've |
| really | hey. i'm really glad you called. |
| go on | i will not go. |
| purple monkey dishwasher | what are his qualifications besides being a white male and directing a hot new |
| asdf | what are his qualifications besides being a white male and directing a hot new |
| the the the | we just missed the turnoff to the party. |
| i was wondering if you could tell me what you think about... | that's right, they're wondering, who's this guy? |
| do you have any thoughts on the future of technology | what are his qualifications besides being a white male and directing a hot new |
| imagine if computers could dream what would they dream about | what are his qualifications besides being a white male and directing a hot new |
