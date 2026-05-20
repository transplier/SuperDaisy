# Eval — bm25seed-movie5k

_Generated 2026-05-20T03:19:35Z by `bin/eval`._

Corpus: `pretrained/movie-5k.DSY` — 5000 sentences, 62535 words
Generator: `classic` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.127 |
| recitation rate (response = a corpus sentence verbatim) | 0.040 |
| acceptance rate (kept / attempted candidates) | 0.099 |
| distinct-2, across all trials | 0.756 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.905 |
| KL(responses ‖ corpus) bigrams, nats | 0.142 |
| latency p50 (ms) | 11.321 |
| latency p95 (ms) | 56.874 |
| KL drift from baseline `baseline-movie5k` (nats) | 0.350 |

Diagnostic counts (kept in JSON): mean attempts 94.633, mean kept 9.333, mean length 11.203 tokens, distinct-3 0.896.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, bomb, are blocked, locked, and you got no one is. they doand maybe they indeed? thank you. |
| hi daisy | hi, vicki. you have four slumps. |
| good morning | good day, sir. or perhaps nietzsche ? |
| how are you | you know he's got dreiberg in seaweed. or "nori" if you prefer. i love sushi. |
| what do you like | what do you take james that it? |
| tell me about yourself | what about the air! louise? talk about? |
| what makes you happy | what it will get you nowhere. truth is, i need it. i don't want to prepare. |
| what is your favorite | how you choose to live your favorite movie star? |
| i had a good day | good day, mister robinson, i fought in spain on mars?! damn! |
| the weather is nice today | it's a nice hot bath, and roger in op/ed. |
| i feel tired | but i think so. no, i get her. get my car back. |
| computers are fun | are you okay? can you move? tim! are you ever spank him? |
| tell me about a platypus | what are you know the other people for a more hilarious funny about those two found each other. |
| what about electricity | what about the parking lot's mostly i tell fortunes. |
| i love astronomy | i always thought jack was ready for the presidency. but i would happen. she told me about. the sun. |
| explain photosynthesis | explain to me you were in your head. |
| describe a unicorn | got a letter from a friend. |
| what do you think | what do i do, the answer it, or i'm sorry i said you had no idea. |
| give me advice | you an' me, and left me why? |
| say something | he say is the part that is used by the use of course you do. |
| anything you want | i'd tell you so mean to let you in the spirit of opportunity. |
| and then what | what are you and your son. |
| really | you're really doing tonight? |
| go on | i'd better go on to the undead surround me. |
| purple monkey dishwasher | easy, there, mom. |
| asdf | easy, there, mom. |
| the the the | would you check out the tent. |
| i was wondering if you could tell me what you think about... | my whole life is your business. |
| do you have any thoughts on the future of technology | the future, marty, the future is it you do things. |
| imagine if computers could dream what would they dream about | i can't imagine ann painted a "skinny little fag" when he'd bag this fucker buzzy. |
