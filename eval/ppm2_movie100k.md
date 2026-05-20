# Eval — ppm2-movie100k

_Generated 2026-05-20T03:39:52Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `ppm:2` | Scorer: `classic` | Sampler: `uniform` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.443 |
| ugliness rate (winner had ugly flag) | 0.160 |
| recitation rate (response = a corpus sentence verbatim) | 0.087 |
| acceptance rate (kept / attempted candidates) | 0.005 |
| distinct-2, across all trials | 0.436 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.912 |
| KL(responses ‖ corpus) bigrams, nats | 0.229 |
| latency p50 (ms) | 78.333 |
| latency p95 (ms) | 159.162 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.822 |

Diagnostic counts (kept in JSON): mean attempts 815.060, mean kept 3.740, mean length 11.977 tokens, distinct-3 0.474.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | you sure this is an old lady just called the hotel, michael. at the end of civilization, the end page? |
| hi daisy | take a look for oil and stuff? |
| good morning | yeah? well i know anybody in the morning when the stiff's an irish, the cops arrested? |
| how are you | goddamn! how long have we been in business? three years. how long did it give you an interview. i never |
| what do you like | that's what you up today. i'd like to sodomize him? would you like it on his desk. |
| tell me about yourself | you take care of yourself, okay? |
| what makes you happy | guess that makes you happy. it's nice to meet david. david... william. |
| what is your favorite | what's your favorite basketball player? |
| i had a good day | over the black man will rise. "we will one day you're going to kill us! |
| the weather is nice today | take a look for oil and stuff? |
| i feel tired | i got tired of looking at you. |
| computers are fun | take a look for oil and stuff? |
| tell me about a platypus | take a look for oil and stuff? |
| what about electricity | take a look for oil and stuff? |
| i love astronomy | take a look for oil and stuff? |
| explain photosynthesis | take a look for oil and stuff? |
| describe a unicorn | take a look for oil and stuff? |
| what do you think | you think bad, and bad is what we have. how is your brother a flyer? |
| give me advice | take a look for oil and stuff? |
| say something | you're two hours or something? |
| anything you want | i've never seen anything so healthy. |
| and then what | where's ken? is he really feels, and then what? then you'll understand. |
| really | this is... really a cop anymore. |
| go on | good god. let's go to jail? |
| purple monkey dishwasher | take a look for oil and stuff? |
| asdf | take a look for oil and stuff? |
| the the the | how could you do if they had to or recognise a punter outside the theater, which is where the hell aren't |
| i was wondering if you could tell me what you think about... | take a look for oil and stuff? |
| do you have any thoughts on the future of technology | take a look for oil and stuff? |
| imagine if computers could dream what would they dream about | take a look for oil and stuff? |
