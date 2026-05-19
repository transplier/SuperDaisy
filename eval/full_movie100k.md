# Eval — full-movie100k

_Generated 2026-05-19T22:57:49Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 10313 sentences, 100008 words
Generator: `ppm:4` | Scorer: `bm25` | max_length: `75` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.100 |
| ugliness rate (winner had ugly flag) | 0.143 |
| recitation rate (response = a corpus sentence verbatim) | 0.710 |
| acceptance rate (kept / attempted candidates) | 0.019 |
| distinct-2, across all trials | 0.672 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.925 |
| KL(responses ‖ corpus) bigrams, nats | 0.200 |
| latency p50 (ms) | 11.683 |
| latency p95 (ms) | 41.939 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.475 |

Diagnostic counts (kept in JSON): mean attempts 407.133, mean kept 7.663, mean length 8.947 tokens, distinct-3 0.748.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | just a half-a-cup. hello, dottie. i'm so sorry to hear of your troubles... |
| hi daisy | hi, happy. well, you're obviously making him happy. |
| good morning | that's not good in prison. it's just not good. |
| how are you | is that how you answer the phone? |
| what do you like | what do you mean? |
| tell me about yourself | i say freddie, what are you about? |
| what makes you happy | you beast, you monster, what have you done to nanook?! what have you done to |
| what is your favorite | deceiving someone without knowing it is something new for me. |
| i had a good day | your call. have a good night. |
| the weather is nice today | it's so nice to meet young men who are so well mannered. |
| i feel tired | i don't think i can walk. |
| computers are fun | are you kidding?! that heap of junk will never leave the ground! |
| tell me about a platypus | so what are you gonna tell him? |
| what about electricity | what about thursdays and fridays? |
| i love astronomy | i don't think i can walk. |
| explain photosynthesis | what are his qualifications besides being a white male and directing a hot new |
| describe a unicorn | oh, a little savage, is he? |
| what do you think | what do you mean? |
| give me advice | dennis won't let me go to the desk. he makes me sit on the floor. |
| say something | can i offer you something. |
| anything you want | oh, no you don't! look, osgood - i'm going to level with you. |
| and then what | what about thursdays and fridays? |
| really | hey. i'm really glad you called. |
| go on | dennis won't let me go to the desk. he makes me sit on the floor. |
| purple monkey dishwasher | what are his qualifications besides being a white male and directing a hot new |
| asdf | what are his qualifications besides being a white male and directing a hot new |
| the the the | we just missed the turnoff to the party. |
| i was wondering if you could tell me what you think about... | there's nothing selfish about pursuing your own life, your own career. |
| do you have any thoughts on the future of technology | yes. you see, the truth is, trinity, that we humans have a place in the future. |
| imagine if computers could dream what would they dream about | water on arrakis!!! i have seen this place in a dream. |
