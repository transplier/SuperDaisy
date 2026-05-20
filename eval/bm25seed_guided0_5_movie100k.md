# Eval — bm25seed-guided0_5-movie100k

_Generated 2026-05-20T05:42:23Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `guided:0.5` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.160 |
| recitation rate (response = a corpus sentence verbatim) | 0.007 |
| acceptance rate (kept / attempted candidates) | 0.095 |
| distinct-2, across all trials | 0.802 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.914 |
| KL(responses ‖ corpus) bigrams, nats | 0.177 |
| latency p50 (ms) | 862.567 |
| latency p95 (ms) | 2603.011 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.403 |

Diagnostic counts (kept in JSON): mean attempts 97.847, mean kept 9.333, mean length 11.343 tokens, distinct-3 0.954.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello, bomb, are you want to her, and ready. |
| hi daisy | hi. how are without the clockcam? |
| good morning | good job, not happy now. |
| how are you | ...the hell are you have i have abundant sperm syndrome. |
| what do you like | what do you gonna end to do you want you should take it up? i didn't have all due respect to take every |
| tell me about yourself | how about your place, or were you?!! |
| what makes you happy | what have you nothin' in the meatballs. |
| what is your favorite | ... your civil human who might be able to meet is nice. |
| i had a good day | no, not okay. here's where did he plays a good model but this... how you know it's the idea. |
| the weather is nice today | nice try. everyone gets her spoken. |
| i feel tired | i don't think i can't be more than an entire life is for my friends. |
| computers are fun | ...are you going to say here's okay. |
| tell me about a platypus | are you sure?... about you. |
| what about electricity | what about this? can i don't drink coffee. |
| i love astronomy | i don't think i don't remember. you to him? |
| explain photosynthesis | explain to me about four of the fucking tongue? |
| describe a unicorn | it's a private - built to cook, maybe white's not a special agent eats a kid brother of it is... really |
| what do you think | i think i ate somethin' at the bogan is what? |
| give me advice | consider me your upper lip give ed klein of you planned for ourselves. |
| say something | say matt, you were excellent tonight, catch on! |
| anything you want | then why are you called you think twice about captain miller, i wish to these must be partners. fiftyfifty. |
| and then what | kenny! what happened? the robbers, and then you agree that go to handle all of looking for too long |
| really | really? me, too! goddamn you! |
| go on | don't go soft on a czech girl. daphne, you don't want to the world. |
| purple monkey dishwasher | he asked me a long as a nigger, you're an institution. |
| asdf | i need your life, a drink from the quadrant. |
| the the the | i think i think, maybe you suddenly care of vigo looked when the end of the other side faster. |
| i was wondering if you could tell me what you think about... | i've been meaning to worry about to invent it. you into the knights you took the safest place. |
| do you have any thoughts on the future of technology | guilty thoughts. see the gastric caecal... |
| imagine if computers could dream what would they dream about | i can't imagine what this is the night, i slept with me. |
