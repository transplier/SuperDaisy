# Eval — baseline-movie100k

_Generated 2026-05-19T22:46:38Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 10313 sentences, 100008 words
Generator: `classic` | Scorer: `classic`
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.443 |
| ugliness rate (winner had ugly flag) | 0.057 |
| recitation rate (response = a corpus sentence verbatim) | 0.007 |
| acceptance rate (kept / attempted candidates) | 0.004 |
| distinct-2, across all trials | 0.536 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.962 |
| KL(responses ‖ corpus) bigrams, nats | 0.223 |
| latency p50 (ms) | 27.300 |
| latency p95 (ms) | 30.274 |

Diagnostic counts (kept in JSON): mean attempts 838.260, mean kept 3.667, mean length 8.043 tokens, distinct-3 0.603.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, mr. cook. i'm talking dire. |
| hi daisy | mommy, could edward take me to take. |
| good morning | ...see you tomorrow morning. |
| how are you | given that, i'm so smart, how many lines of here. |
| what do you like | i'd like to quit, friend? |
| tell me about yourself | huh. but it's not good for a change. keep her for yourself. |
| what makes you happy | is he making him happy. |
| what is your favorite | are you hungry? what's your favorite actor on... |
| i had a good day | from day one. |
| the weather is nice today | he's got that information is classified. you're there to monitor the weather. |
| i feel tired | mommy, could edward take me to take. |
| computers are fun | mommy, could edward take me to take. |
| tell me about a platypus | mommy, could edward take me to take. |
| what about electricity | mommy, could edward take me to take. |
| i love astronomy | mommy, could edward take me to take. |
| explain photosynthesis | mommy, could edward take me to take. |
| describe a unicorn | mommy, could edward take me to take. |
| what do you think | i don't know. sometimes i think i'm going to find? |
| give me advice | mommy, could edward take me to take. |
| say something | we must write the books should do something? |
| anything you want | think? well, what can you do anything careless. |
| and then what | well... then may be? |
| really | really. turn 'er up a little. |
| go on | go get a little better. what about the moon? |
| purple monkey dishwasher | mommy, could edward take me to take. |
| asdf | mommy, could edward take me to take. |
| the the the | dennis won't let the blow drive the boat down the road. at all? |
| i was wondering if you could tell me what you think about... | mommy, could edward take me to take. |
| do you have any thoughts on the future of technology | mommy, could edward take me to take. |
| imagine if computers could dream what would they dream about | mommy, could edward take me to take. |
