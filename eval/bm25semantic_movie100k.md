# Eval — bm25semantic-movie100k

_Generated 2026-05-20T05:22:31Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `classic` | Scorer: `bm25` | Sampler: `uniform` | Seed: `semantic` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.143 |
| recitation rate (response = a corpus sentence verbatim) | 0.077 |
| acceptance rate (kept / attempted candidates) | 0.068 |
| distinct-2, across all trials | 0.693 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.842 |
| KL(responses ‖ corpus) bigrams, nats | 0.184 |
| latency p50 (ms) | 7.680 |
| latency p95 (ms) | 73.123 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.416 |

Diagnostic counts (kept in JSON): mean attempts 134.057, mean kept 9.123, mean length 10.837 tokens, distinct-3 0.825.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | this is april lee, auggie. april, say hello to see what's going to ask her sole rebuttal was bad, it was |
| hi daisy | yes... hi sarris... how are you are. |
| good morning | well, congratulations! good game, but i'm sorry i had to look good. |
| how are you | q! how are there. so you yesterday? |
| what do you like | great. what do understand that there's not a man with a sense of humor. |
| tell me about yourself | how about you feel the first rem-cycle probably won't see ya. |
| what makes you happy | what makes you know. i got a restraining order in? |
| what is your favorite | your hand is gender- neutral? i mean, what am out of my bags. i've checked them in. |
| i had a good day | perhaps i had to look good. |
| the weather is nice today | yeah, the tree makes it nice. |
| i feel tired | i think i had better stay. it's better than the ones we vere thinking there something i should be king! |
| computers are fun | who are you? are you ok? |
| tell me about a platypus | tell me, 007, what do you got an attempted firebombing at the secret? |
| what about electricity | ok. what should be committed. |
| i love astronomy | oh i love me -. |
| explain photosynthesis | you can't expect me to explain the thuggee shrine i saw right now. |
| describe a unicorn | it's a tightrope, spud, a fucking god. you're gay. |
| what do you think | what do you don't know, do understand that there's not a man with a sense of humor. |
| give me advice | give me your safety, but she better answer the harp. as i can. |
| say something | is there something to say? |
| anything you want | what do you mean, he might help if you or your fuckin' tired. haven't slept with her once you leave twon, |
| and then what | and then what do you mean, ross? |
| really | no. really. for a bus? |
| go on | come on. let's go somewhere and i'm gearjamming this way. |
| purple monkey dishwasher | i'm not positive... but... he knows. |
| asdf | i'm not positive... but... he knows. |
| the the the | while the rest of the family was killed when was the last time. don't believe that shit? |
| i was wondering if you could tell me what you think about... | my whole life never understanding me. |
| do you have any thoughts on the future of technology | the future, marty, the future is a regular eli whitney on a record label and two getting here. |
| imagine if computers could dream what would they dream about | i can't imagine not being with me? |
