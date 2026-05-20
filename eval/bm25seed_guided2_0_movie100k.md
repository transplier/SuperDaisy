# Eval — bm25seed-guided2_0-movie100k

_Generated 2026-05-20T05:42:10Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `guided:2.0` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.067 |
| ugliness rate (winner had ugly flag) | 0.167 |
| recitation rate (response = a corpus sentence verbatim) | 0.007 |
| acceptance rate (kept / attempted candidates) | 0.097 |
| distinct-2, across all trials | 0.771 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.908 |
| KL(responses ‖ corpus) bigrams, nats | 0.174 |
| latency p50 (ms) | 786.416 |
| latency p95 (ms) | 2332.422 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.423 |

Diagnostic counts (kept in JSON): mean attempts 96.460, mean kept 9.330, mean length 11.157 tokens, distinct-3 0.946.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello. so very simple as a bat! |
| hi daisy | hi, dick. i'm gonna see that. you think i... |
| good morning | that's all i skipped town; came from, and you advice? good morning, mr. boone. freedom is it? |
| how are you | how long do understand what are you? |
| what do you like | you'd be surprised what do i could do i don't even have been up in your mind? |
| tell me about yourself | cool out. i tell here or five more to find us. |
| what makes you happy | tell you what. worstick's a corpse? it's craig out of this bastard can be a butcher? what did this is |
| what is your favorite | your husband is your line. |
| i had a good day | questions can amount of you had lou read by your mom went off in all! |
| the weather is nice today | oh, that's nice, too. |
| i feel tired | wait. i have been sorta discourages you picked that i thought i was finally your house? |
| computers are fun | are you the time. |
| tell me about a platypus | how about another article on his name - almost ready for years ago did your help. |
| what about electricity | what are you, pearl. come up for you think about the other. |
| i love astronomy | i don't know when i just borrow any press? |
| explain photosynthesis | explain to me crazy, but you want anyhow? what happened? |
| describe a unicorn | you don't have a minute to a very same rules says the check. they don't put you that service i doing |
| what do you think | i know what is going to spend the street, i don't think i can't be your friend, you didn't know how |
| give me advice | not for you, isn't it they sent me for me, for the one of them on me. |
| say something | i'll just say all week. |
| anything you want | you should have to last. you're a man would you think if you wanted to hear me one to you have our ships |
| and then what | what will he joined up and i had sex and we don't know how far so much of tea parties in the way i like |
| really | they're not really don't know. |
| go on | i go up fast. who's his fucking angry, for everything. |
| purple monkey dishwasher | he asked me a long as a nigger, you're an institution. |
| asdf | i need your life, a drink from the quadrant. |
| the the the | we have to oedipus, i sent the car we can make the game... |
| i was wondering if you could tell me what you think about... | i've been meaning to change. |
| do you have any thoughts on the future of technology | future man would set you been taken. |
| imagine if computers could dream what would they dream about | you can' t imagine ann painted this is it was. |
