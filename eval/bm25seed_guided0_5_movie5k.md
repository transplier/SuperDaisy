# Eval — bm25seed-guided0_5-movie5k

_Generated 2026-05-20T05:24:06Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `guided:0.5` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.200 |
| recitation rate (response = a corpus sentence verbatim) | 0.013 |
| acceptance rate (kept / attempted candidates) | 0.102 |
| distinct-2, across all trials | 0.796 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.924 |
| KL(responses ‖ corpus) bigrams, nats | 0.137 |
| latency p50 (ms) | 427.343 |
| latency p95 (ms) | 534.413 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.360 |

Diagnostic counts (kept in JSON): mean attempts 77.633, mean kept 7.957, mean length 11.833 tokens, distinct-3 0.955.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello walter. i treat your shadow will it in your record. any ideas, miss it. |
| hi daisy | hi, dick. i'm talking about, connie? |
| good morning | take good care of yourself - i've got faces that was going to pee? |
| how are you | are you peter parker, how to do. |
| what do you like | you know what he slaughtered that simple. now we don't care where, what i should've known. me like a |
| tell me about yourself | i can't tell her being paid $300,000 to spend the movie star? |
| what makes you happy | listen, what are getting a whiff of marriage and, if they won't find him speak, and what you tell me |
| what is your favorite | your hand is named baby - this can't see the french guy who you don't like i said something daddy doesn't |
| i had a good day | good day, sir. in the place to go do when we do i think i'd like a few friends for you. |
| the weather is nice today | it's so nice guy. |
| i feel tired | i thought i never see things. i have you? |
| computers are fun | who are we cannot accept bank are the end of joke? i want my instruction? |
| tell me about a platypus | listen...don't you worry about. who has always present. the guy that and what makes you care about the |
| what about electricity | what does grandma think about you. |
| i love astronomy | i been in anything. i can't be getting jack-legged by my impression of nerve than you don't expect an |
| explain photosynthesis | explain to me alone. |
| describe a unicorn | that's a good hands, baby! those are we were saying, i don't want to make a distant memory. |
| what do you think | what do you get out for you, either. what else coming along little dog. next mornin'. diggin' in group! |
| give me advice | if i give ed klein of resurrecting park's, harris has heard he knew what you're telling me and padiche, |
| say something | something else. do you alone? |
| anything you want | sure, they did you would have a driving at? you ever steered you weren't looking for my mind. |
| and then what | four brothers and i am i serve the weapons and here's the ghosts... |
| really | do you really feel through any color... no one who's to maranzano, that before. |
| go on | i've thought about her on a nigger, you're looking everywhere. maybe you do. |
| purple monkey dishwasher | my lawyer agrees with them out for this. |
| asdf | i think he's the raven in detention, deprived of here all of humor? |
| the the the | i might as it is, so what's at the deceased, any social advice about stock, clouds the shops... |
| i was wondering if you could tell me what you think about... | that's life. what happened to the mood for. |
| do you have any thoughts on the future of technology | guilty thoughts. see it can love all the future of the world turned down from thy bed, there are beautiful. |
| imagine if computers could dream what would they dream about | i can't imagine that, would have you feel? |
