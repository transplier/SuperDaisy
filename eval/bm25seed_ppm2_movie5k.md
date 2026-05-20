# Eval — bm25seed-ppm2-movie5k

_Generated 2026-05-20T04:15:17Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `ppm:2` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.173 |
| recitation rate (response = a corpus sentence verbatim) | 0.150 |
| acceptance rate (kept / attempted candidates) | 0.105 |
| distinct-2, across all trials | 0.717 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.851 |
| KL(responses ‖ corpus) bigrams, nats | 0.149 |
| latency p50 (ms) | 19.882 |
| latency p95 (ms) | 152.439 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.422 |

Diagnostic counts (kept in JSON): mean attempts 88.717, mean kept 9.333, mean length 11.090 tokens, distinct-3 0.821.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | this is april lee, auggie. april, say hello to auggie wren. |
| hi daisy | hi. how are things with john? |
| good morning | are we good? yeah, we're good. we're beautiful. we're perfect. this is my wife? |
| how are you | what are you afraid the empire might discover this little show is for the mariners. why don't you just |
| what do you like | jeez... that sounds awful. hey, what do you think you can have any idea what this land'll be worth with |
| tell me about yourself | so talk to us about the animals. you tell when somebody's hittin' on you? |
| what makes you happy | what are you doing?! |
| what is your favorite | your hand is bleeding. |
| i had a good day | we had a quiet drink? i had a crush on the "send?" turns out this ducking moe was an officer candidate |
| the weather is nice today | it's a nice restaurants. |
| i feel tired | i have a burger by myself. i feel stupid babbling about my eyesight? it's lousy, that's what! lila's |
| computers are fun | what are you gonna answer me? what'd you say that! |
| tell me about a platypus | how do you know anything about that? |
| what about electricity | who said anything about what you would know, dummy. |
| i love astronomy | i been q-ing you all night, i left my car, yesterday. |
| explain photosynthesis | explain to me now. |
| describe a unicorn | a quarter of a way to the hedges? could you come here and forgot him. |
| what do you think | "what about you? what sins have you been up to? |
| give me advice | it doesn't matter. it only proper to pay me last night. |
| say something | mm. well, say what you saw today, have you? |
| anything you want | the nanobot is still inside you. it's the homo angle. maybe they don't want anything? |
| and then what | you know what time it is? |
| really | i really like him, rose. he's so... ...passionate about his work. |
| go on | way to go, mom! |
| purple monkey dishwasher | no thanks, i needed that. |
| asdf | no thanks, i needed that. |
| the the the | what is it... the secret? |
| i was wondering if you could tell me what you think about... | my life is your friend. |
| do you have any thoughts on the future of technology | the future, marty, the future that you were talking about this big. |
| imagine if computers could dream what would they dream about | i can't imagine being with you last night. |
