# Eval — bm25seed-guided0_5-movie5k

_Generated 2026-05-20T05:41:22Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `guided:0.5` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.193 |
| recitation rate (response = a corpus sentence verbatim) | 0.017 |
| acceptance rate (kept / attempted candidates) | 0.097 |
| distinct-2, across all trials | 0.768 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.920 |
| KL(responses ‖ corpus) bigrams, nats | 0.138 |
| latency p50 (ms) | 679.173 |
| latency p95 (ms) | 1686.352 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.374 |

Diagnostic counts (kept in JSON): mean attempts 96.187, mean kept 9.333, mean length 11.360 tokens, distinct-3 0.921.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, this is that kid i mean, cash... that i'm gonna talk me a whole dog-and-pony show. |
| hi daisy | hi, dick. i'm talking about, connie? |
| good morning | good seeing you love a good guys go get my mother? |
| how are you | are you peter parker, how to do. |
| what do you like | you know what he slaughtered that simple. now we don't care where, what i should've known. me like a |
| tell me about yourself | i was in nebraska. didn't give me about other protective purposes? |
| what makes you happy | listen, what are getting a whiff of marriage and, if they won't find him speak, and what you tell me |
| what is your favorite | your hand is named baby - this can't see the french guy who you don't like i said something daddy doesn't |
| i had a good day | good day, sir. in the place to go do when we do i think i'd like a few friends for you. |
| the weather is nice today | ...as of today, hooker. you know i love allison, don't want! |
| i feel tired | i thought i never see things. i have you? |
| computers are fun | who are we cannot accept bank are the end of joke? i want my instruction? |
| tell me about a platypus | listen...don't you worry about. who has always present. the guy that and what makes you care about the |
| what about electricity | what does grandma think about you. |
| i love astronomy | i been in anything. i can't be getting jack-legged by my impression of nerve than you don't expect an |
| explain photosynthesis | explain to me sir, he's reman. |
| describe a unicorn | that's a good hands, baby! those are we were saying, i don't want to make a distant memory. |
| what do you think | what do you get out for you, either. what else coming along little dog. next mornin'. diggin' in group! |
| give me advice | if i give ed klein of resurrecting park's, harris has heard he knew what you're telling me and padiche, |
| say something | something else. do you alone? |
| anything you want | sure, they did you would have a driving at? you ever steered you weren't looking for my mind. |
| and then what | four brothers and i am i serve the weapons and here's the ghosts... |
| really | do you really feel through any color... no one who's to maranzano, that before. |
| go on | go on. sit down. |
| purple monkey dishwasher | home school. til this thing, here, just thinking, you should be able to tell us to bust your own master |
| asdf | home school. til this thing, here, just thinking, you should be able to tell us to bust your own master |
| the the the | i might as it is, so what's at the deceased, any social advice about stock, clouds the shops... |
| i was wondering if you could tell me what you think about... | i've been meaning to leave. |
| do you have any thoughts on the future of technology | guilty thoughts. see it can love all the future of the world turned down from thy bed, there are beautiful. |
| imagine if computers could dream what would they dream about | you can' t imagine you're just like you quiet drink? i don't want me say that what do me too. |
