# Eval — bm25t07-movie5k

_Generated 2026-05-20T05:22:59Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `classic` | Scorer: `bm25` | Sampler: `temperature:0.7` | Seed: `uniform` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.323 |
| ugliness rate (winner had ugly flag) | 0.227 |
| recitation rate (response = a corpus sentence verbatim) | 0.013 |
| acceptance rate (kept / attempted candidates) | 0.096 |
| distinct-2, across all trials | 0.569 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.979 |
| KL(responses ‖ corpus) bigrams, nats | 0.154 |
| latency p50 (ms) | 515.246 |
| latency p95 (ms) | 564.957 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.467 |

Diagnostic counts (kept in JSON): mean attempts 37.913, mean kept 3.627, mean length 12.823 tokens, distinct-3 0.634.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | would you check on scott. he's never disobeyed me about it. |
| hi daisy | yo. check this isn' t some blood here. |
| good morning | yeah. could be. |
| how are you | when do you shouldn't have to the commissary to figure out, did you see this? |
| what do you like | when do you shouldn't have to the commissary to figure out, did you see this? |
| tell me about yourself | would you check on scott. he's never disobeyed me about it. |
| what makes you happy | poof! you're happy - you know, my dream has to double in fairvale ledgers! mrs. peel's black leather |
| what is your favorite | ... whatever is your homework, larry. |
| i had a good day | don't use my life has had been beneath us a hundred and just die ! |
| the weather is nice today | has this happened out there? why you're really here. |
| i feel tired | i can see your beauty? |
| computers are fun | hey, get this thing. right now that you are you sure you broke my heart. |
| tell me about a platypus | no. i can tell you that. |
| what about electricity | yeah. they've been vampire, there has what you have. |
| i love astronomy | mom, you hitched all the way it revolutionizes how i faked the hidden agenda? |
| explain photosynthesis | explain to me it'll always be in here. |
| describe a unicorn | don't use my life has had been beneath us a hundred and just die ! |
| what do you think | yeah. they've been vampire, there has what you have. |
| give me advice | and if you better give me too. |
| say something | what did laura say? do you can't hurt people... |
| anything you want | when do you shouldn't have to the commissary to figure out, did you see this? |
| and then what | yeah? what about it. i think we can get it. you'll understand. |
| really | has this happened out there? why you're really here. |
| go on | would you check on scott. he's never disobeyed me about it. |
| purple monkey dishwasher | roger, keep calling them. knock off the record for you. in case you haven't noticed. |
| asdf | so you killed nobody, has he, mama? |
| the the the | no. it's her i'm married, will see the arrest of the man all the way to the other side of the man's ethics, he's |
| i was wondering if you could tell me what you think about... | don't use my life has had been beneath us a hundred and just die ! |
| do you have any thoughts on the future of technology | it was the future. you can get my butt kicked for this. |
| imagine if computers could dream what would they dream about | poof! you're happy - you know, my dream has to double in fairvale ledgers! mrs. peel's black leather |
