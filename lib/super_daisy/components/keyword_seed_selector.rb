# Stage 3a alternative — prompt-aware seed selector.
#
# Interface: #call(corpus, sampler, rng, keywords:) -> Array<String> | nil
#
# Behavior: collect every corpus sentence that contains any of the
# keywords (each sentence appears once per matching keyword — natural
# density weighting). Sample one from that pool. If no sentence matches
# any keyword, fall back to a uniform random sentence.
#
# Kernel intact: every emitted token is still verbatim from the corpus.
# The walker that runs after this selector is unchanged. We just stop
# starting walks at a uniformly-random point and start them at a
# topically-relevant one. The famous off-topic chaos is preserved at
# the Markov-step level — only the *first* step has prompt awareness.

module SuperDaisy
  module Components
    class KeywordSeedSelector
      def call(corpus, sampler, rng, keywords: [])
        sents = corpus.sentences
        return nil if sents.empty?
        return sampler.call(sents, rng) if keywords.empty?

        # Pool of sentences containing at least one keyword, with
        # multiplicity per keyword hit — sentences with more keywords
        # appear more often, biasing toward keyword-dense seeds.
        pool = []
        keywords.each do |kw|
          corpus.sentences_containing(kw).each do |idx|
            pool << sents[idx]
          end
        end

        return sampler.call(sents, rng) if pool.empty?
        sampler.call(pool, rng)
      end
    end
  end
end
