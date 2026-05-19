# Eval — bm25t07-movie100k

_Generated 2026-05-19T23:16:54Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `classic` | Scorer: `bm25` | Sampler: `temperature:0.7` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.310 |
| ugliness rate (winner had ugly flag) | 0.227 |
| recitation rate (response = a corpus sentence verbatim) | 0.033 |
| acceptance rate (kept / attempted candidates) | 0.112 |
| distinct-2, across all trials | 0.475 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.978 |
| KL(responses ‖ corpus) bigrams, nats | 0.192 |
| latency p50 (ms) | 515.462 |
| latency p95 (ms) | 538.937 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.591 |

Diagnostic counts (kept in JSON): mean attempts 34.710, mean kept 3.887, mean length 12.243 tokens, distinct-3 0.527.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | i can't believe your life is a sailor on it. |
| hi daisy | ...on the way out... |
| good morning | this could be so good for a drink. andrews enters and knocks several times. receiving no response, he |
| how are you | the financials are you packed? ready stand to smooth and kissable. just can't fly. |
| what do you like | ...what do you know what your holiness care to me. what's your cousin is more than pick acorns and rob bird's |
| tell me about yourself | you keep looking at these. i needed to tell you were different, or were you as well! |
| what makes you happy | so we understand you. what is what goes on his neck. so, pick up your general knowledge of power is stronger |
| what is your favorite | so we understand you. what is what goes on his neck. so, pick up your general knowledge of power is stronger |
| i had a good day | day jobs, yeah. he says that this is right. |
| the weather is nice today | that was beautiful to watch, howard. like a surgeon or a concert in altamount when the supper had two operations on |
| i feel tired | veronica, i love to get you a gun. just the right moment, you feel like your blender, only violators and practical |
| computers are fun | some people fall sick we'll be transferred to a bunch. when do care about are you doing? |
| tell me about a platypus | you keep looking at these. i needed to tell you were different, or were you as well! |
| what about electricity | so we understand you. what is what goes on his neck. so, pick up your general knowledge of power is stronger |
| i love astronomy | veronica, i love to get you a gun. just the right moment, you feel like your blender, only violators and practical |
| explain photosynthesis | i promised iran to townsend. |
| describe a unicorn | that was beautiful to watch, howard. like a surgeon or a concert in altamount when the supper had two operations on |
| what do you think | ...what do you know what your holiness care to me. what's your cousin is more than pick acorns and rob bird's |
| give me advice | i can't tell me why? |
| say something | i told you. you saw something. |
| anything you want | i told you. you saw something. |
| and then what | ...what do you know what your holiness care to me. what's your cousin is more than pick acorns and rob bird's |
| really | no, i really ... |
| go on | go on. sit still. it's not planning on it. |
| purple monkey dishwasher | i promised iran to townsend. |
| asdf | i promised iran to townsend. |
| the the the | ...on the way out... |
| i was wondering if you could tell me what you think about... | i can't believe your life is a sailor on it. |
| do you have any thoughts on the future of technology | yeah, i do. |
| imagine if computers could dream what would they dream about | i promised iran to townsend. |
