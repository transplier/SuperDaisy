# Stage 3a — Seed selector (default).
#
# Interface: #call(corpus, sampler, rng, keywords:) -> Array<String> | nil
#            (a sentence's tokens; nil if corpus is empty)
#
# Default behavior: pick a sentence uniformly at random, ignoring the
# keywords entirely. This is the canonical DAISY behavior — generation
# is prompt-blind, the rejection sampler does all the topic-matching.

module SuperDaisy
  module Components
    class UniformSeedSelector
      def call(corpus, sampler, rng, keywords: [])
        sents = corpus.sentences
        return nil if sents.empty?
        sampler.call(sents, rng)
      end
    end
  end
end
