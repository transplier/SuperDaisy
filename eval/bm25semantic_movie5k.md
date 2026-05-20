# Eval — bm25semantic-movie5k

_Generated 2026-05-20T04:16:10Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `classic` | Scorer: `bm25` | Sampler: `uniform` | Seed: `semantic` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.163 |
| recitation rate (response = a corpus sentence verbatim) | 0.083 |
| acceptance rate (kept / attempted candidates) | 0.068 |
| distinct-2, across all trials | 0.705 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.841 |
| KL(responses ‖ corpus) bigrams, nats | 0.151 |
| latency p50 (ms) | 5.070 |
| latency p95 (ms) | 44.651 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.389 |

Diagnostic counts (kept in JSON): mean attempts 133.057, mean kept 9.040, mean length 10.300 tokens, distinct-3 0.830.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | just... just wanted to say hello... |
| hi daisy | hi. how are okay. |
| good morning | are we good? yeah, we're good. can i see you. |
| how are you | q! how are there. so you yesterday? |
| what do you like | what do you had what it at the table? |
| tell me about yourself | so tell me get this part of us that i can give him it? |
| what makes you happy | what? why? what else did he sees himself in vegas? |
| what is your favorite | keep your friends close and your record. let me how neatly 'three' went into the man a hug, boy! that's your |
| i had a good day | anyway, i had it coming. |
| the weather is nice today | nice talking to carry on. |
| i feel tired | yeah, i guess the dozer musta shifted him? you worry about ed. but i guess i give a franklin mint piece. |
| computers are fun | why are you mean, he might help if you and your son. |
| tell me about a platypus | wait. what about anyway. that's where credit is due. |
| what about electricity | wait. what about what happened? |
| i love astronomy | mordechai, i love you more'n more, she's made two employees. i take it. |
| explain photosynthesis | ...who didn't much like myself. do they explain your men do. |
| describe a unicorn | i was playing a trick. i-i-i had a baseball. |
| what do you think | what do you don't know, do fine. besides, he's doing. |
| give me advice | did i give me that zippo. |
| say something | okay to say that out loud as you want to say. before you kill others. |
| anything you want | don't you want you to help her with her tightly, tears in a counter-punch! anything in german since |
| and then what | and what do your thing. |
| really | you're really something, dad. you better get your things from now on. |
| go on | go on. sit tight. i'll make the preparations. |
| purple monkey dishwasher | easy, there, mom. |
| asdf | easy, there, mom. |
| the the the | where the hell's the matter with these wedding gifts. she's being so alarming about the ship, huh? |
| i was wondering if you could tell me what you think about... | my whole life as a plumber - an ordinary, flesh and blood i'll go back. |
| do you have any thoughts on the future of technology | the future, marty, the future is so passionate and dangerous" .. |
| imagine if computers could dream what would they dream about | i can't imagine what his anus is like? describe it, deanna? |
