# Eval — bm25seed-guided1_0-movie5k

_Generated 2026-05-20T05:40:46Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `guided:1.0` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.183 |
| recitation rate (response = a corpus sentence verbatim) | 0.017 |
| acceptance rate (kept / attempted candidates) | 0.097 |
| distinct-2, across all trials | 0.754 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.921 |
| KL(responses ‖ corpus) bigrams, nats | 0.139 |
| latency p50 (ms) | 627.285 |
| latency p95 (ms) | 1482.710 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.375 |

Diagnostic counts (kept in JSON): mean attempts 95.757, mean kept 9.333, mean length 11.590 tokens, distinct-3 0.914.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, this is special. that was another beer? |
| hi daisy | yes... hi sarris... how are procedures, beth, that ugly jealous side. |
| good morning | well, good, ed. he'll be the gun was good. |
| how are you | that's very simple as long as you a lot safer at long after he does? you hate for an actor, so you don't |
| what do you like | what do i can make you in the missiles. been here? |
| tell me about yourself | what about the undead surround me. i'm gonna rest of dat laundry gig was given to stay. |
| what makes you happy | what man? what the way? |
| what is your favorite | i don't mean fred flintstone is it, and your own hours to play in this is it, man. |
| i had a good day | this is good. like a good reporter that he worships me. outsider can't find this year. unless we're |
| the weather is nice today | it's gonna be nice. |
| i feel tired | i show you. i feel then, lord willing, we'll have to do what happens to something. |
| computers are fun | ...what are you too. |
| tell me about a platypus | yep. right about those at that night, after this research. |
| what about electricity | what about the rope. i see some chemical shit all day. |
| i love astronomy | i wish i suppose i want. |
| explain photosynthesis | explain to me all right. |
| describe a unicorn | a republican is that car thieves are no insights here, two were there a football. i just a whole lot |
| what do you think | what do they thought you feel? |
| give me advice | why me? shaw is giving me where it a man and he calls in the rest her for this nurse... |
| say something | i'll say that service i can feel my life. |
| anything you want | do you have to pass on this very carefully, benjamin. you have possession of, do with the storm. |
| and then what | what do you in the fight. then why didn't you? |
| really | i'm not really are. |
| go on | does he go on the set here! a car. |
| purple monkey dishwasher | home school. til this thing, here, just thinking, you should be able to tell us to bust your own master |
| asdf | home school. til this thing, here, just thinking, you should be able to tell us to bust your own master |
| the the the | my dad. he and look around the eyes in the horses. they're up in the street and i call your ticket, |
| i was wondering if you could tell me what you think about... | that's life. what the two days, weeks, i'm alive. when that upset. |
| do you have any thoughts on the future of technology | what about the opera house with the future? |
| imagine if computers could dream what would they dream about | i can't imagine not sure. |
