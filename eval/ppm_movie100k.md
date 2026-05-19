# Eval — ppm-movie100k

_Generated 2026-05-19T22:46:50Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 10313 sentences, 100008 words
Generator: `ppm:4` | Scorer: `classic`
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.470 |
| ugliness rate (winner had ugly flag) | 0.053 |
| recitation rate (response = a corpus sentence verbatim) | 0.800 |
| acceptance rate (kept / attempted candidates) | 0.004 |
| distinct-2, across all trials | 0.477 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.935 |
| KL(responses ‖ corpus) bigrams, nats | 0.227 |
| latency p50 (ms) | 38.587 |
| latency p95 (ms) | 42.950 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.773 |

Diagnostic counts (kept in JSON): mean attempts 849.633, mean kept 3.517, mean length 8.473 tokens, distinct-3 0.527.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | just a half-a-cup. hello, dottie. i'm so sorry to hear of your troubles... |
| hi daisy | have you ever thrown up in the front row of a richard marx concert? |
| good morning | then i expect you'll be leaving first thing in the morning. |
| how are you | but how did you get "kwan?" _ 82. |
| what do you like | it was like an internal struggle going on inside my body. |
| tell me about yourself | why give yourself up? |
| what makes you happy | hi, happy. well, you're obviously making him happy. |
| what is your favorite | are you hungry? what's your favorite food? we'll try to get it for you. |
| i had a good day | oh, it just came to me one day. |
| the weather is nice today | have you ever thrown up in the front row of a richard marx concert? |
| i feel tired | have you ever thrown up in the front row of a richard marx concert? |
| computers are fun | have you ever thrown up in the front row of a richard marx concert? |
| tell me about a platypus | have you ever thrown up in the front row of a richard marx concert? |
| what about electricity | have you ever thrown up in the front row of a richard marx concert? |
| i love astronomy | have you ever thrown up in the front row of a richard marx concert? |
| explain photosynthesis | have you ever thrown up in the front row of a richard marx concert? |
| describe a unicorn | have you ever thrown up in the front row of a richard marx concert? |
| what do you think | did he just say what i think he said? |
| give me advice | have you ever thrown up in the front row of a richard marx concert? |
| say something | am i in trouble or something? |
| anything you want | well, anything coulda caused that. |
| and then what | ...then you rip my clothes off. then we rip lyndsey's clothes off. i think |
| really | hey. i'm really glad you called. |
| go on | i will not go. |
| purple monkey dishwasher | have you ever thrown up in the front row of a richard marx concert? |
| asdf | have you ever thrown up in the front row of a richard marx concert? |
| the the the | we just missed the turnoff to the party. |
| i was wondering if you could tell me what you think about... | that's right, they're wondering, who's this guy? |
| do you have any thoughts on the future of technology | have you ever thrown up in the front row of a richard marx concert? |
| imagine if computers could dream what would they dream about | have you ever thrown up in the front row of a richard marx concert? |
