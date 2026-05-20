# Eval — bm25seed-guided2_0-movie100k

_Generated 2026-05-20T05:24:54Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `guided:2.0` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.077 |
| ugliness rate (winner had ugly flag) | 0.187 |
| recitation rate (response = a corpus sentence verbatim) | 0.000 |
| acceptance rate (kept / attempted candidates) | 0.119 |
| distinct-2, across all trials | 0.777 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.924 |
| KL(responses ‖ corpus) bigrams, nats | 0.173 |
| latency p50 (ms) | 511.947 |
| latency p95 (ms) | 558.679 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.412 |

Diagnostic counts (kept in JSON): mean attempts 58.017, mean kept 6.903, mean length 11.463 tokens, distinct-3 0.954.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello walter. i dig him, i recognize you... i never know. |
| hi daisy | hi, dick. i'm gonna see that. you think i... |
| good morning | that's all i skipped town; came from, and you advice? good morning, mr. boone. freedom is it? |
| how are you | how long do understand what are you? |
| what do you like | you'd be surprised what do i could do i don't even have been up in your mind? |
| tell me about yourself | you can't die naked! and tell her flight...". |
| what makes you happy | tell you what. worstick's a corpse? it's craig out of this bastard can be a butcher? what did this is |
| what is your favorite | no... but it is something else, major... |
| i had a good day | thought you had devoted half a pig intestines for? |
| the weather is nice today | oh, that's nice, fat ankles. |
| i feel tired | wait. i have been sorta discourages you picked that i thought i was finally your house? |
| computers are fun | are you the time. |
| tell me about a platypus | are you sure?... about a bus. |
| what about electricity | what are you, pearl. come up for you think about the other. |
| i love astronomy | i don't know when i just borrow any press? |
| explain photosynthesis | explain to me a wife used to customers aren't i? |
| describe a unicorn | you don't have a minute to a very same rules says the check. they don't put you that service i doing |
| what do you think | i know what is going to spend the street, i don't think i can't be your friend, you didn't know how |
| give me advice | not for you, isn't it they sent me for me, for the one of them on me. |
| say something | i'll just say all week. |
| anything you want | you should have to last. you're a man would you think if you wanted to hear me one to you have our ships |
| and then what | what will he joined up and i had sex and we don't know how far so much of tea parties in the way i like |
| really | they're not really don't know. |
| go on | hey, listen... i'll go out... is your daughter, but circumstances arose. |
| purple monkey dishwasher | he asked me about to be enough money?! huh? i could have you agree that got the way. |
| asdf | then put him dead and feast on it. |
| the the the | we have to oedipus, i sent the car we can make the game... |
| i was wondering if you could tell me what you think about... | my life is white van mccoy for the rich and just perfect bait for this traveling theater apart! |
| do you have any thoughts on the future of technology | future man would set up in the last, then go along. that's a suitcase vibrates, the plane? |
| imagine if computers could dream what would they dream about | you can' t imagine not a parent if i gotta choose from. |
