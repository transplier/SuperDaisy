# Eval — bm25t05-movie5k

_Generated 2026-05-20T04:17:26Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `classic` | Scorer: `bm25` | Sampler: `temperature:0.5` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.300 |
| ugliness rate (winner had ugly flag) | 0.233 |
| recitation rate (response = a corpus sentence verbatim) | 0.030 |
| acceptance rate (kept / attempted candidates) | 0.095 |
| distinct-2, across all trials | 0.549 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.968 |
| KL(responses ‖ corpus) bigrams, nats | 0.155 |
| latency p50 (ms) | 509.511 |
| latency p95 (ms) | 538.670 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.496 |

Diagnostic counts (kept in JSON): mean attempts 47.480, mean kept 4.497, mean length 12.033 tokens, distinct-3 0.609.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | can you now? |
| hi daisy | can you now? |
| good morning | hi, vicki. you are beautiful, and that damned garden. |
| how are you | but it seems that way. you doing? you're bothering you? |
| what do you like | great. what do that for me, 007, what do you need? |
| tell me about yourself | none, there's nothing because all of myself as more time...shit, she's had a look too? |
| what makes you happy | great. what do that for me, 007, what do you need? |
| what is your favorite | i really shouldn't. i gotta keep your friends close and your enemies list. you got an attempted firebombing |
| i had a good day | none, there's nothing because all of myself as more time...shit, she's had a look too? |
| the weather is nice today | i gotta catch up on old and out of cops. did you are being nice name. william, i'd say that's a great time, and |
| i feel tired | i don't know, the elevator man dies. not every brother i knew how sick they are living creatures out there. |
| computers are fun | hi, vicki. you are beautiful, and that damned garden. |
| tell me about a platypus | she hasn't called your god-damned office! i want you remember about five more minutes. okay? |
| what about electricity | great. what do that for me, 007, what do you need? |
| i love astronomy | i hesitated taking her down to be love. |
| explain photosynthesis | what do i had no idea... |
| describe a unicorn | yeah, dad. i'm a wealthy man around than herbie temple at the fuckin' phone and we have a joke? |
| what do you think | great. what do that for me, 007, what do you need? |
| give me advice | it'll be so i could see me around that where you're family finances. i want from me? |
| say something | i gotta catch up on old and out of cops. did you are being nice name. william, i'd say that's a great time, and |
| anything you want | but it seems that way. you doing? you're bothering you? |
| and then what | it's going to read and then we can't hack it any more. |
| really | i really shouldn't. i gotta keep your friends close and your enemies list. you got an attempted firebombing |
| go on | i see them on the other day, you asked a lot of 459's and he lies out on you. |
| purple monkey dishwasher | "agent low's theory that you should be tossed out of jail. i did. i call me don. |
| asdf | yes! yes! we know where he never arrived. |
| the the the | how much of the elite special to me. you don't?! well, get her to the atlantic on its recovery. |
| i was wondering if you could tell me what you think about... | if my life a few times. receiving no response, he gingerly opens the door. |
| do you have any thoughts on the future of technology | yes! yes! we know where he never arrived. |
| imagine if computers could dream what would they dream about | oh, that was i doing on the table by the store's clerk. |
