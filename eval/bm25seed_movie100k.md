# Eval — bm25seed-movie100k

_Generated 2026-05-20T05:20:51Z by `bin/eval`._

Corpus: `pretrained/movie-100k.DSY` — 7937 sentences, 100012 words
Generator: `classic` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `overlap` | max_length: `98` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.063 |
| ugliness rate (winner had ugly flag) | 0.177 |
| recitation rate (response = a corpus sentence verbatim) | 0.023 |
| acceptance rate (kept / attempted candidates) | 0.098 |
| distinct-2, across all trials | 0.787 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.908 |
| KL(responses ‖ corpus) bigrams, nats | 0.182 |
| latency p50 (ms) | 30.963 |
| latency p95 (ms) | 145.687 |
| KL drift from baseline `baseline-movie100k` (nats) | 0.383 |

Diagnostic counts (kept in JSON): mean attempts 95.180, mean kept 9.307, mean length 11.437 tokens, distinct-3 0.919.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | hello walter. i can't live without me! |
| hi daisy | hi, it's me. |
| good morning | that's not good stuff was cut out, but i told you not wearing a belt. |
| how are you | you don't think about you?". |
| what do you like | what do i don't think her boyfriend's been cut that shit out. |
| tell me about yourself | tell him about this one? |
| what makes you happy | what do you sure run a guy. |
| what is your favorite | your daddy is out there... ...help, we're in here! |
| i had a good day | but good words. |
| the weather is nice today | halden, how nice to have nice guy who's about shari you say you were hunting? |
| i feel tired | i can't fly anymore, i'm gonna like what i must speak with the hair. |
| computers are fun | what are you take james that it? |
| tell me about a platypus | hey, don't tell anyone about your homework? |
| what about electricity | what are you meant... yes, i'm cool. |
| i love astronomy | i... i don't know what you're okay? |
| explain photosynthesis | explain to me and my big windows at the idea? |
| describe a unicorn | tell me a dog, it'll be here, so you didn't hear any further here, mr. ward told me "son.". |
| what do you think | do what you got an attempted firebombing at the secret? |
| give me advice | give me your opportunity, grab it! |
| say something | say something it's just casually on what we do you advise it? |
| anything you want | you jerk! you that you owe me five bucks. this gun gets washed away. why the rat? |
| and then what | divert power and the girls get going though. |
| really | i'm really lost. you'll never live with it. then make it so. |
| go on | let's go and lloyd had a leg, ladies. |
| purple monkey dishwasher | he asked me up, scotty! |
| asdf | i'm not positive... but... he knows. |
| the the the | in the middle of the street right after your looks are pale and wild and look? |
| i was wondering if you could tell me what you think about... | my life is my doing. this time. |
| do you have any thoughts on the future of technology | the future, marty, the future is that you? |
| imagine if computers could dream what would they dream about | can you imagine a parrot nipping a man? |
