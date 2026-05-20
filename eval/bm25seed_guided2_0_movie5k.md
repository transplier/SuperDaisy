# Eval — bm25seed-guided2_0-movie5k

_Generated 2026-05-20T05:40:42Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `guided:2.0` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.233 |
| recitation rate (response = a corpus sentence verbatim) | 0.020 |
| acceptance rate (kept / attempted candidates) | 0.099 |
| distinct-2, across all trials | 0.745 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.911 |
| KL(responses ‖ corpus) bigrams, nats | 0.136 |
| latency p50 (ms) | 615.263 |
| latency p95 (ms) | 1447.425 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.377 |

Diagnostic counts (kept in JSON): mean attempts 94.517, mean kept 9.333, mean length 11.863 tokens, distinct-3 0.913.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, my little student doing? they're acting class. |
| hi daisy | hi. this is wired it. you like 'em - through about it. |
| good morning | pretty good imitation of 'em. lot easier. |
| how are you | you sure looked it. you're lost. i'm sorry for all those are you were dead. you trying all right? |
| what do you like | what the hell does so what should be talking about what have i want you play, man. too sure the fall |
| tell me about yourself | what about the border! |
| what makes you happy | what? why? what i'm going to this is tower. |
| what is your favorite | your hand is named baby - this is this trip. |
| i had a good day | good of you guys had a kid. |
| the weather is nice today | let nice guy is in the man would hear something you around to do, the brain. |
| i feel tired | i thought i know about forty five years and there were dead. my night? i'm not wise beyond her away, |
| computers are fun | are you okay? you are. |
| tell me about a platypus | i know i'm about taxes, only been looking for? |
| what about electricity | about 250 million people and cheese in front about the way? |
| i love astronomy | i told you. i've ever lasting covenant and i can't do i took my procedures. and bring the big boy. he's |
| explain photosynthesis | explain to me sooner. |
| describe a unicorn | great. what do you think i was heart attack a piece of me for a song coming through your own. like hell |
| what do you think | what do they concern me. |
| give me advice | brodski i'll talk me look, let me to be a man through which we can i meant... |
| say something | say, young fella, wasn't defending you. |
| anything you want | yeah, um, then...are you understand, you was bad, was right behind me and a little bad for what about |
| and then what | what do they coulda made me by any way here is what? |
| really | oh really? that's no one's atf. and missed you and i have any number three. |
| go on | or worse, we'll go on the third man. |
| purple monkey dishwasher | home school. til this thing, here, just thinking, you should be able to tell us to bust your own master |
| asdf | home school. til this thing, here, just thinking, you should be able to tell us to bust your own master |
| the the the | you know, roberta sparrow. we haven't the cave. tonight and the mounted police are clear on the ones. |
| i was wondering if you could tell me what you think about... | if my life i dunno. at me a girl. |
| do you have any thoughts on the future of technology | the future, marty, the school. i never left me sir, you to have any patience for. |
| imagine if computers could dream what would they dream about | you can' t imagine ann painted this time of his. |
