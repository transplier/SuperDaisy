# Eval — bm25-movie5k

_Generated 2026-05-19T22:57:43Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 507 sentences, 5005 words
Generator: `classic` | Scorer: `bm25` | max_length: `77` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.113 |
| ugliness rate (winner had ugly flag) | 0.200 |
| recitation rate (response = a corpus sentence verbatim) | 0.077 |
| acceptance rate (kept / attempted candidates) | 0.019 |
| distinct-2, across all trials | 0.460 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.824 |
| KL(responses ‖ corpus) bigrams, nats | 0.204 |
| latency p50 (ms) | 4.060 |
| latency p95 (ms) | 23.157 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.447 |

Diagnostic counts (kept in JSON): mean attempts 411.403, mean kept 7.673, mean length 10.290 tokens, distinct-3 0.559.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, sir. it's not rats and you never heard of rock 'n roll? |
| hi daisy | don't worry, i'm always happy to assuage any qualms you have about the time she |
| good morning | all in good time, mister mcmurphy. all in good time. |
| how are you | i'm a professional. you guys are sitting out there a man and you tell me a little somethin' |
| what do you like | you don't like that? you won't even have to be out, like, a total babe. |
| tell me about yourself | how about a minute? |
| what makes you happy | what are you think something is dead! |
| what is your favorite | this is day care. its where she is, tell me what this otis redding single off you? |
| i had a good day | all in good time, mister mcmurphy. all in good time. |
| the weather is nice today | are we done for today? |
| i feel tired | of course i do, and i don't want mulvihill. i want the basement? |
| computers are fun | where are you see it? |
| tell me about a platypus | how about a minute? |
| what about electricity | what about your neck will break. |
| i love astronomy | of course i do, and i don't want mulvihill. i want the basement? |
| explain photosynthesis | i never sent for the police. we can explain. |
| describe a unicorn | i'm a professional. you guys are sitting out there a man and you tell me a little somethin' |
| what do you think | you don't know what to say... |
| give me advice | thanks for clearing that up. i want to sleep. give me five minutes on that freak me out? |
| say something | yes. to keep something from us, but they'd never get home. |
| anything you want | you don't like that? you won't even have to be out, like, a total babe. |
| and then what | then what is the most fiendish instrument of torture experiments, nathan. |
| really | i really don't take chances. my brother, but you this mornin'. |
| go on | figured enough to have the loudest house on the police are on a torpedo - i'll help. please. |
| purple monkey dishwasher | don't worry, i'm always happy to assuage any qualms you have about the time she |
| asdf | don't worry, i'm always happy to assuage any qualms you have about the time she |
| the the the | figured enough to have the loudest house on the police are on a torpedo - i'll help. please. |
| i was wondering if you could tell me what you think about... | and my dad for the rest of your life. it's not easy being a woman. |
| do you have any thoughts on the future of technology | a future. the cause of humanity, helmuth. or should have more than i do. |
| imagine if computers could dream what would they dream about | don't worry, i'm always happy to assuage any qualms you have about the time she |
