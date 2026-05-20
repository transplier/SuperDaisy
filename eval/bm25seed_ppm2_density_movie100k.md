# Eval — bm25seed-ppm2-density-movie100k

_Generated 2026-05-20T04:15:23Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `ppm:2` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `density` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.063 |
| ugliness rate (winner had ugly flag) | 0.040 |
| recitation rate (response = a corpus sentence verbatim) | 0.323 |
| acceptance rate (kept / attempted candidates) | 0.102 |
| distinct-2, across all trials | 0.699 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.780 |
| KL(responses ‖ corpus) bigrams, nats | 0.192 |
| latency p50 (ms) | 31.156 |
| latency p95 (ms) | 91.488 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.526 |

Diagnostic counts (kept in JSON): mean attempts 91.300, mean kept 9.307, mean length 5.470 tokens, distinct-3 0.809.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello walter. i want and you don't know what i did. |
| hi daisy | hi. how are you? |
| good morning | good morning, sir. how can it be? |
| how are you | who are you? are you doing here? |
| what do you like | that's true. i do. |
| tell me about yourself | tell me about the leopard. |
| what makes you happy | what did you bring them? |
| what is your favorite | none of your own. |
| i had a good day | good job, not pretty, but good. |
| the weather is nice today | halden, how nice to have a fella? |
| i feel tired | i don't know ... |
| computers are fun | they are carrying guns. they are carrying guns. they are very interested in him. |
| tell me about a platypus | don't worry about it. |
| what about electricity | what does that mean? |
| i love astronomy | i need this, roy. i can't say it. |
| explain photosynthesis | explain to me sooner. |
| describe a unicorn | i've got a plan! |
| what do you think | i think he knows that. |
| give me advice | that's fine with me. |
| say something | i'll say that all right? |
| anything you want | i had to. you help me, i'll help you. |
| and then what | what do we do? |
| really | oh, yeah, really, oh! |
| go on | better go on back to czechoslovakia. |
| purple monkey dishwasher | he asked me to do a drug deal, you watch your tongue. |
| asdf | take a look for oil and stuff? |
| the the the | hallo, this is the problem? |
| i was wondering if you could tell me what you think about... | he sells insurance for metropolitan life. |
| do you have any thoughts on the future of technology | the future, mr. gittes. |
| imagine if computers could dream what would they dream about | can you imagine a parrot nipping a man? |
