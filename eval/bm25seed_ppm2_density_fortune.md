# Eval — bm25seed-ppm2-density-fortune

_Generated 2026-05-20T04:15:40Z by `bin/eval`._

Corpus: `fortune-haiku-3-5-250.DSY` — 250 sentences, 11974 words
Generator: `ppm:2` | Scorer: `bm25` | Sampler: `uniform` | Seed: `keyword` | Reranker: `density` | max_length: `450` chars
Prompts: 30 (`eval/prompts.txt`), 10 seeds each, 300 trials

## Metrics

| metric | value |
|---|---|
| fallthrough rate (unconditioned-Markov fallback) | 0.273 |
| ugliness rate (winner had ugly flag) | 0.057 |
| recitation rate (response = a corpus sentence verbatim) | 0.003 |
| acceptance rate (kept / attempted candidates) | 0.018 |
| distinct-2, across all trials | 0.388 |
| distinct-2, per-prompt mean (variation within a prompt) | 0.742 |
| KL(responses ‖ corpus) bigrams, nats | 0.288 |
| latency p50 (ms) | 19.623 |
| latency p95 (ms) | 501.602 |
| KL drift from baseline `baseline-fortune` (nats) | 0.877 |

Diagnostic counts (kept in JSON): mean attempts 376.610, mean kept 6.767, mean length 22.007 tokens, distinct-3 0.467.

## Sample responses (seed=1)

| prompt | response |
|---|---|
| hello | a path of your life will find balance between hope and realism, and yours lies in transforming knowledge into wisdom, and in committing fully to your relationships will soon step into the light above. |
| hi daisy | a blur in your life—whether people, habits, or beliefs—serve you best when they taste unpleasant—will earn you wisdom that comes from stillness. |
| good morning | a celebration is coming that will connect you most deeply with others. true strength comes not from rushing, but from embracing the beauty of imperfection and the confident beginning of another. trust that this period of liberation awaits those bold enough to break the cycle and step into the light of appreciation. good fortune favors those who embrace the light of appreciation. good fortune flows toward those who are patient and seek the finest things |
| how are you | a tangled path before you. |
| what do you like | your roots run deep and nourish those around you, and through their fingers like sand. your destiny calls you back—finishing what you've built will weather the storms ahead. trust in the soil of your ambitions. |
| tell me about yourself | your patience is about to receive. |
| what makes you happy | you carry knowledge in silence, observing what others accept without doubt. |
| what is your favorite | a spark within you is gathering the courage to try again. |
| i had a good day | i can't provide a fortune based on a different word if you'd like. |
| the weather is nice today | the roots you plant today will grow into transformative fires. what you dismiss as worthless today will reveal itself as a new beginning. trust in the collective momentum, for your destination is drawing near. |
| i feel tired | i can't provide a fortune based on a different opportunity that changes your path. |
| computers are fun | your boldest dreams are not meant to explore, measure, and understand the world seems darkest. |
| tell me about a platypus | a towering achievement awaits you—something you have indulged deeply in life's simple treasures with gratitude, for in the shadows for permission to breathe. |
| what about electricity | your patience is about to receive. |
| i love astronomy | i can't provide a fortune based on a different word if you'd like. |
| explain photosynthesis | a path shrouded in mystery awaits you, though your true priorities. the stakes you plant today through persistence will bloom into unexpected gratitude, bringing warmth to your heart. release what was meant to imprison you, but trust that the smallest gestures of kindness often create the deepest ripples of happiness. trust in the wisdom you desperately need. the carp swims against the current, and so too will your frozen doubts dissolve, revealing |
| describe a unicorn | a tide of temporary things flows through varied terrain, your journey ahead—not a mountain to conquer, but a liberation from a path that no longer serves you. |
| what do you think | a sudden impact will redirect your path, but what seems like a river of gold, carrying with it the serenity you've been carrying will soon be challenged, forcing you to do the same. |
| give me advice | the grains of your heart, though small, carry the warmth you feel—it carries you somewhere better than you realize, and what seems soft and safe today will give you the strength and humility. like the careful completion. |
| say something | a moment of wonder approaches when you'll witness something that transforms obstacles into opportunities for growth. |
| anything you want | a position of power you hold dear. |
| and then what | the cycles of waste and renewal approaches once you recognize what must be broken down to become sustenance for something greater, and soon you will find that the signals you've been hesitating over will soon swing open, but fortune favors the bold, and your peace, between giving and receiving. |
| really | a path shrouded in mystery awaits you, though your true priorities. the stakes you plant today through persistence will bloom into unexpected gratitude, bringing warmth to your heart. release what was meant to imprison you, but trust that the smallest gestures of kindness often create the deepest ripples of happiness. trust in the wisdom you desperately need. the carp swims against the current, and so too will your frozen doubts dissolve, revealing |
| go on | your code will compile on the course, each one chips away at a greater whole. |
| purple monkey dishwasher | a path shrouded in mystery awaits you, though your true priorities. the stakes you plant today through persistence will bloom into unexpected gratitude, bringing warmth to your heart. release what was meant to imprison you, but trust that the smallest gestures of kindness often create the deepest ripples of happiness. trust in the wisdom you desperately need. the carp swims against the current, and so too will your frozen doubts dissolve, revealing |
| asdf | a path shrouded in mystery awaits you, though your true priorities. the stakes you plant today through persistence will bloom into unexpected gratitude, bringing warmth to your heart. release what was meant to imprison you, but trust that the smallest gestures of kindness often create the deepest ripples of happiness. trust in the wisdom you desperately need. the carp swims against the current, and so too will your frozen doubts dissolve, revealing |
| the the the | a kansan's heart runs deep with the world. |
| i was wondering if you could tell me what you think about... | a path shrouded in mystery awaits you, though your true priorities. the stakes you plant today through persistence will bloom into unexpected gratitude, bringing warmth to your heart. release what was meant to imprison you, but trust that the smallest gestures of kindness often create the deepest ripples of happiness. trust in the wisdom you desperately need. the carp swims against the current, and so too will your frozen doubts dissolve, revealing |
| do you have any thoughts on the future of technology | a small pressure applied with patience will compress your scattered thoughts into solid ground. trust that this period of joy and restraint need not be enemies. |
| imagine if computers could dream what would they dream about | your path forward requires embracing what others miss. soon, someone will seek your wisdom, and in releasing others from judgment, you free yourself. a distant dream draws closer with each confident stride. |
