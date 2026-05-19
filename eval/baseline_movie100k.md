# Eval — baseline-movie100k

_Generated 2026-05-19T22:57:24Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 10313 sentences, 100008 words
Generator: `classic` | Scorer: `classic` | max_length: `75` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.440 |
| ugliness rate (winner had ugly flag) | 0.093 |
| recitation rate (response = a corpus sentence verbatim) | 0.053 |
| acceptance rate (kept / attempted candidates) | 0.004 |
| distinct-2, across all trials | 0.534 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.966 |
| KL(responses ‖ corpus) bigrams, nats | 0.220 |
| latency p50 (ms) | 26.879 |
| latency p95 (ms) | 27.998 |

Diagnostic counts (kept in JSON): mean attempts 835.687, mean kept 3.667, mean length 8.347 tokens, distinct-3 0.589.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, mr. cook. i'm talking dire. |
| hi daisy | wire burn. trying to make a real lady killer. |
| good morning | ...see you tomorrow morning. |
| how are you | how fascinating. do you remember this isn't happening. |
| what do you like | i'd like to quit, friend? |
| tell me about yourself | huh. but it's not good for a change. keep her for yourself. |
| what makes you happy | is he making him happy. |
| what is your favorite | there were no kidding. he's a big favorite in carl's well was in it, okay? |
| i had a good day | is that what should we do it. you got pinched twice for about a day. |
| the weather is nice today | he's got that information is classified. you're there to monitor the weather. |
| i feel tired | wire burn. trying to make a real lady killer. |
| computers are fun | wire burn. trying to make a real lady killer. |
| tell me about a platypus | wire burn. trying to make a real lady killer. |
| what about electricity | wire burn. trying to make a real lady killer. |
| i love astronomy | wire burn. trying to make a real lady killer. |
| explain photosynthesis | wire burn. trying to make a real lady killer. |
| describe a unicorn | wire burn. trying to make a real lady killer. |
| what do you think | you're right. i think there's nice guy, but i'm with you on it. |
| give me advice | wire burn. trying to make a real lady killer. |
| say something | and if i was afraid something here. |
| anything you want | think? well, what can you do anything careless. |
| and then what | well... then may be? |
| really | really. turn 'er up a little. |
| go on | then don't go to rikers? go to is a symptom of their teeth. |
| purple monkey dishwasher | wire burn. trying to make a real lady killer. |
| asdf | wire burn. trying to make a real lady killer. |
| the the the | dennis won't let the blow drive the boat down the road. at all? |
| i was wondering if you could tell me what you think about... | oh my god knows the meaning for me. |
| do you have any thoughts on the future of technology | wire burn. trying to make a real lady killer. |
| imagine if computers could dream what would they dream about | wire burn. trying to make a real lady killer. |
