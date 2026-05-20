# Eval — bm25t07-movie100k

_Generated 2026-05-20T05:23:11Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `classic` | Scorer: `bm25` | Sampler: `temperature:0.7` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.340 |
| ugliness rate (winner had ugly flag) | 0.217 |
| recitation rate (response = a corpus sentence verbatim) | 0.027 |
| acceptance rate (kept / attempted candidates) | 0.116 |
| distinct-2, across all trials | 0.472 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.981 |
| KL(responses ‖ corpus) bigrams, nats | 0.192 |
| latency p50 (ms) | 522.621 |
| latency p95 (ms) | 602.413 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.587 |

Diagnostic counts (kept in JSON): mean attempts 26.197, mean kept 3.040, mean length 12.227 tokens, distinct-3 0.522.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | when we're done, but i've gotta get you to grow! |
| hi daisy | i hope you cannot lie to memory. |
| good morning | this could be so good for a drink. andrews enters and knocks several times. receiving no response, he |
| how are you | i told you. you saw something. |
| what do you like | ...what do you know what your holiness care to me. what's your cousin is more than pick acorns and rob bird's |
| tell me about yourself | that we fired before ten o'clock. i was having an affair with worry, out of yourself, okay? |
| what makes you happy | ...what do you know what your holiness care to me. what's your cousin is more than pick acorns and rob bird's |
| what is your favorite | ...what do you know what your holiness care to me. what's your cousin is more than pick acorns and rob bird's |
| i had a good day | day jobs, yeah. he says that this is right. |
| the weather is nice today | ...on the way out... |
| i feel tired | veronica, i love to get you a gun. just the right moment, you feel like your blender, only violators and practical |
| computers are fun | some people fall sick we'll be transferred to a bunch. when do care about are you doing? |
| tell me about a platypus | some people fall sick we'll be transferred to a bunch. when do care about are you doing? |
| what about electricity | so we understand you. what is what goes on his neck. so, pick up your general knowledge of power is stronger |
| i love astronomy | veronica, i love to get you a gun. just the right moment, you feel like your blender, only violators and practical |
| explain photosynthesis | ...on the way out... |
| describe a unicorn | i can't believe your life is a sailor on it. |
| what do you think | ...what do you know what your holiness care to me. what's your cousin is more than pick acorns and rob bird's |
| give me advice | ...what do you know what your holiness care to me. what's your cousin is more than pick acorns and rob bird's |
| say something | i told you. you saw something. |
| anything you want | i told you. you saw something. |
| and then what | ...what do you know what your holiness care to me. what's your cousin is more than pick acorns and rob bird's |
| really | no, i really ... |
| go on | go on. sit still. it's not planning on it. |
| purple monkey dishwasher | "spontaneous." i like hitler? |
| asdf | "spontaneous." i like hitler? |
| the the the | ...on the way out... |
| i was wondering if you could tell me what you think about... | i can't believe your life is a sailor on it. |
| do you have any thoughts on the future of technology | you keep looking at these. i needed to tell you were different, or were you as well! |
| imagine if computers could dream what would they dream about | i can't tell me why? |
