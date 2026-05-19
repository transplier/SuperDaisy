# Eval — bm25-movie5k

_Generated 2026-05-19T22:46:41Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 507 sentences, 5005 words
Generator: `classic` | Scorer: `bm25`
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.110 |
| ugliness rate (winner had ugly flag) | 0.230 |
| recitation rate (response = a corpus sentence verbatim) | 0.107 |
| acceptance rate (kept / attempted candidates) | 0.018 |
| distinct-2, across all trials | 0.453 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.814 |
| KL(responses ‖ corpus) bigrams, nats | 0.210 |
| latency p50 (ms) | 4.293 |
| latency p95 (ms) | 22.877 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.478 |

Diagnostic counts (kept in JSON): mean attempts 417.237, mean kept 7.653, mean length 9.900 tokens, distinct-3 0.551.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, sir. it's not rats and you never heard of rock 'n roll? |
| hi daisy | hi, jerry. everything under control? |
| good morning | all in good time, mister mcmurphy. all in good time. |
| how are you | i'm a professional. you guys are sitting out there a man and you tell me |
| what do you like | you don't like that? you won't even have to be out, like, a total babe. |
| tell me about yourself | how about a professional. you guys are in my enthusiasm. |
| what makes you happy | what are you think something is dead! |
| what is your favorite | this is day care. its where she is, tell me what this otis redding single |
| i had a good day | all in good time, mister mcmurphy. all in good time. |
| the weather is nice today | but then we done for today? |
| i feel tired | of course i do, and i don't want mulvihill. i want the basement? |
| computers are fun | a fellow sees a fire go when their parents are at work. |
| tell me about a platypus | how about a professional. you guys are in my enthusiasm. |
| what about electricity | what about your neck will break. |
| i love astronomy | of course i do, and i don't want mulvihill. i want the basement? |
| explain photosynthesis | well i remember that trip we can explain. |
| describe a unicorn | i'm a professional. you guys are sitting out there a man and you tell me |
| what do you think | howya do, rebecca. i sorta been doing some research in the archives. |
| give me advice | thanks for clearing that up. i want to sleep. give me five minutes on that |
| say something | even that would be something special. |
| anything you want | of course i do, and i don't want mulvihill. i want the basement? |
| and then what | then what is the most fiendish instrument of torture experiments, nathan. |
| really | really? what are you going to contact her. |
| go on | figured enough to have the loudest house on the police are on a torpedo - |
| purple monkey dishwasher | why? just give me some form... |
| asdf | why? just give me some form... |
| the the the | figured enough to have the loudest house on the police are on a torpedo - |
| i was wondering if you could tell me what you think about... | and my dad for the rest of your life. it's not easy being a woman. |
| do you have any thoughts on the future of technology | a future. the stones, she swallows the poison berries too. that's what i think? |
| imagine if computers could dream what would they dream about | why? just give me some form... |
