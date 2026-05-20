# Eval — bm25seed-density-movie100k

_Generated 2026-05-20T05:50:37Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `classic` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `density` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.063 |
| ugliness rate (winner had ugly flag) | 0.033 |
| recitation rate (response = a corpus sentence verbatim) | 0.070 |
| acceptance rate (kept / attempted candidates) | 0.098 |
| distinct-2, across all trials | 0.765 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.856 |
| KL(responses ‖ corpus) bigrams, nats | 0.194 |
| latency p50 (ms) | 15.943 |
| latency p95 (ms) | 61.625 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.445 |

Diagnostic counts (kept in JSON): mean attempts 95.247, mean kept 9.337, mean length 5.640 tokens, distinct-3 0.886.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, my little tighter. |
| hi daisy | hi, it's me. |
| good morning | they make gypsies look good. |
| how are you | you don't think about you?". |
| what do you like | hey! what about what happened? |
| tell me about yourself | tell him about this one? |
| what makes you happy | so what is involved. |
| what is your favorite | ... your civil tongue in your time here? |
| i had a good day | but good words. |
| the weather is nice today | that's really nice restaurants. |
| i feel tired | i stood up on old times? |
| computers are fun | why are you then? |
| tell me about a platypus | what about us? |
| what about electricity | what piece? richard crookback? |
| i love astronomy | i... i don't know what you're okay? |
| explain photosynthesis | explain to me why? |
| describe a unicorn | sounds like a wish. |
| what do you think | do what you got an attempted firebombing at the secret? |
| give me advice | fuck me, man! |
| say something | say something it's just casually on what we do you advise it? |
| anything you want | where do you want from me? |
| and then what | it's what i've found! |
| really | oh, yeah, really, oh! |
| go on | come on, man. |
| purple monkey dishwasher | he asked me up, scotty! |
| asdf | i'm not positive... but... he knows. |
| the the the | and so, jabez stone, in the department. |
| i was wondering if you could tell me what you think about... | she's wondering what's the problem? |
| do you have any thoughts on the future of technology | the future, mr. newcombe. |
| imagine if computers could dream what would they dream about | can you imagine a parrot nipping a man? |
