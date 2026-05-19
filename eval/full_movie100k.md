# Eval — full-movie100k

_Generated 2026-05-19T22:46:46Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 10313 sentences, 100008 words
Generator: `ppm:4` | Scorer: `bm25`
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.103 |
| ugliness rate (winner had ugly flag) | 0.137 |
| recitation rate (response = a corpus sentence verbatim) | 0.727 |
| acceptance rate (kept / attempted candidates) | 0.019 |
| distinct-2, across all trials | 0.660 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.923 |
| KL(responses ‖ corpus) bigrams, nats | 0.201 |
| latency p50 (ms) | 12.698 |
| latency p95 (ms) | 44.098 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.467 |

Diagnostic counts (kept in JSON): mean attempts 408.273, mean kept 7.647, mean length 8.723 tokens, distinct-3 0.731.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | just a half-a-cup. hello, dottie. i'm so sorry to hear of your troubles... |
| hi daisy | hi, happy. well, you're obviously making him happy. |
| good morning | that's not good in prison. it's just not good. |
| how are you | is that how you answer the phone? |
| what do you like | what do you mean? |
| tell me about yourself | so what are you gonna tell him? |
| what makes you happy | you beast, you monster, what have you done to nanook?! what have you done |
| what is your favorite | deceiving someone without knowing it is something new for me. |
| i had a good day | your call. have a good night. |
| the weather is nice today | it's so nice to meet young men who are so well mannered. |
| i feel tired | i don't think i can walk. |
| computers are fun | are you kidding?! that heap of junk will never leave the ground! |
| tell me about a platypus | he's a man. tell him you're a man. |
| what about electricity | what about thursdays and fridays? |
| i love astronomy | i don't think i can walk. |
| explain photosynthesis | have you ever thrown up in the front row of a richard marx concert? |
| describe a unicorn | oh, a little savage, is he? |
| what do you think | what do you mean? |
| give me advice | dennis won't let me go to the desk. he makes me sit on the floor. |
| say something | can i offer you something. |
| anything you want | oh, no you don't! look, osgood - i'm going to level with you. |
| and then what | what about thursdays and fridays? |
| really | hey. i'm really glad you called. |
| go on | dennis won't let me go to the desk. he makes me sit on the floor. |
| purple monkey dishwasher | have you ever thrown up in the front row of a richard marx concert? |
| asdf | have you ever thrown up in the front row of a richard marx concert? |
| the the the | we just missed the turnoff to the party. |
| i was wondering if you could tell me what you think about... | there's nothing selfish about pursuing your own life, your own career. |
| do you have any thoughts on the future of technology | have you ever thrown up in the front row of a richard marx concert? |
| imagine if computers could dream what would they dream about | water on arrakis!!! i have seen this place in a dream. |
