# Eval — bm25seed-guided0_5-movie100k

_Generated 2026-05-20T05:24:53Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `guided:0.5` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.083 |
| ugliness rate (winner had ugly flag) | 0.183 |
| recitation rate (response = a corpus sentence verbatim) | 0.007 |
| acceptance rate (kept / attempted candidates) | 0.120 |
| distinct-2, across all trials | 0.803 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.922 |
| KL(responses ‖ corpus) bigrams, nats | 0.177 |
| latency p50 (ms) | 509.290 |
| latency p95 (ms) | 546.306 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.401 |

Diagnostic counts (kept in JSON): mean attempts 58.683, mean kept 7.020, mean length 11.280 tokens, distinct-3 0.952.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello walter. i think, but i recognize you... i knew a sellout but we had...gone to find a duck blind... |
| hi daisy | hi. how are without the clockcam? |
| good morning | good. i'd miss johnson? |
| how are you | ...the hell are you have i have abundant sperm syndrome. |
| what do you like | what do you gonna end to do you want you should take it up? i didn't have all due respect to take every |
| tell me about yourself | i'm sorry about the house. |
| what makes you happy | what have you nothin' in the meatballs. |
| what is your favorite | ... your civil human who might be able to meet is nice. |
| i had a good day | pretty good imitation of a million dollars' worth on you. |
| the weather is nice today | nice try. everyone gets her spoken. |
| i feel tired | i don't think i can't be more than an entire life is for my friends. |
| computers are fun | ...are you going to say here's okay. |
| tell me about a platypus | you talking about money to kill fifteen hundred. we'll pick some thanks... |
| what about electricity | what about this? can i don't drink coffee. |
| i love astronomy | i don't think i don't remember. you to him? |
| explain photosynthesis | explain to me how do fucked up to turn them interesting though? i think you don't call him out. |
| describe a unicorn | it's a private - built to cook, maybe white's not a special agent eats a kid brother of it is... really |
| what do you think | i think i ate somethin' at the bogan is what? |
| give me advice | you amaze me, they've ever had. |
| say something | say matt, you were excellent tonight, catch on! |
| anything you want | then why are you called you think twice about captain miller, i wish to these must be partners. fiftyfifty. |
| and then what | kenny! what happened? the robbers, and then you agree that go to handle all of looking for too long |
| really | you really should. my help. |
| go on | go tell him on the little of lost their numbers. one of you finished college. i guess by my training |
| purple monkey dishwasher | he asked me play was gonna pay for you. |
| asdf | he just got leak. |
| the the the | i think i think, maybe you suddenly care of vigo looked when the end of the other side faster. |
| i was wondering if you could tell me what you think about... | if my life right after all. |
| do you have any thoughts on the future of technology | guilty thoughts. see that? |
| imagine if computers could dream what would they dream about | can you imagine not forget. |
