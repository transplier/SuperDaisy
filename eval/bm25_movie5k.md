# Eval — bm25-movie5k

_Generated 2026-05-20T05:50:39Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `classic` | Scorer: `bm25` | Sampler: `uniform` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.087 |
| ugliness rate (winner had ugly flag) | 0.213 |
| recitation rate (response = a corpus sentence verbatim) | 0.040 |
| acceptance rate (kept / attempted candidates) | 0.021 |
| distinct-2, across all trials | 0.637 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.948 |
| KL(responses ‖ corpus) bigrams, nats | 0.143 |
| latency p50 (ms) | 21.007 |
| latency p95 (ms) | 107.352 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.340 |

Diagnostic counts (kept in JSON): mean attempts 370.820, mean kept 7.897, mean length 12.780 tokens, distinct-3 0.736.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | i came down and say hello. |
| hi daisy | yes... hi sarris... how are you know, i was i asleep? |
| good morning | the good old to be a hundred thousand francs for all of him with me. |
| how are you | we are clear at the outset that all matters not. long you have four slumps. |
| what do you like | what? why? what the hell's going to be a good livin' here... |
| tell me about yourself | oh, that. i can tell. a goddam thing... the hell, darling. close ... |
| what makes you happy | what? why? what the hell's going to be a good livin' here... |
| what is your favorite | home school. til this is over. |
| i had a good day | jamie needs a truly good person. and... she loves you so much, i just had to build him or anything, did |
| the weather is nice today | it isn't cheap. it's nice. |
| i feel tired | i don't really shouldn't. i gotta figure some way of life. |
| computers are fun | no! don't kill fifteen hundred a-year out of the only thing we are neither. are we now? |
| tell me about a platypus | oh, that. i can tell. a goddam thing... the hell, darling. close ... |
| what about electricity | what? why? what the hell's going to be a good livin' here... |
| i love astronomy | i don't really shouldn't. i gotta figure some way of life. |
| explain photosynthesis | hundredth cabinet meeting. she tried to explain. she had written. you must reboot and type alarm system. |
| describe a unicorn | i hesitated taking a lot of juice. we try to talk me how. i do you mean dr. towler on a 7-11. any town, |
| what do you think | what? why? what the hell's going to be a good livin' here... |
| give me advice | no. not at me. you broke the bread, gave me some new ones in estonia. |
| say something | um ... you will be judged. have you anything to say. there was a breeze. i told him to sign that? |
| anything you want | thank you, but you said call him nice, but now's the time you'll ever have. |
| and then what | what? why? what the hell's going to be a good livin' here... |
| really | really? perhaps your wife. |
| go on | no big deal. set up the hell he is. a bird on the ferry. |
| purple monkey dishwasher | easy, there, mom. |
| asdf | easy, there, mom. |
| the the the | looking for... the last drop, if another ship had to guess by now if that be all right? |
| i was wondering if you could tell me what you think about... | there you are, sitting next to negotiate. what about my life. |
| do you have any thoughts on the future of technology | what does that way. you didn't expect to see a motherfucker with my future wife. |
| imagine if computers could dream what would they dream about | this isn' t imagine them, jean luc. they're kids! all with advance degrees in xenobiology and out to |
