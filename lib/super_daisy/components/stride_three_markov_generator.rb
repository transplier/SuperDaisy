# Stage 3 — Candidate sentence generator.
#
# Interface: #call(seed:, corpus:, sampler:, rng:, terminators:, max_length:)
#            -> sentence_string
#
# `seed` is an Array<String> of the sentence-start tokens to begin the
# walk from — selected by the orchestrator's SeedSelector. Pass an empty
# array to get an empty response.
#
# Default behavior: take the first 3 tokens of seed, then 1st-order
# Markov walk with stride-3 emission. Every random choice goes through
# the sampler. Returns when the trailing bigram is a known sentence-
# ender, when the walk falls off the corpus, or when the sentence
# exceeds max_length.
#
# Ugly-flag detection lives in SuperDaisy::Ugly and is run by the Bot
# orchestrator on the returned sentence.

module SuperDaisy
  module Components
    class StrideThreeMarkovGenerator
      def call(seed:, corpus:, sampler:, rng:, terminators:, max_length:, keywords: nil)
        return "" if seed.nil? || seed.empty?

        words = seed.first(3).dup

        loop do
          last = words.last
          positions = corpus.positions_of(last)
          break if positions.empty?

          idx = sampler.call(positions, rng)
          chunk = []
          (1..3).each do |k|
            nxt = corpus.tokens[idx + k]
            break if nxt.nil? || nxt == SuperDaisy::SENTINEL
            chunk << nxt
          end
          break if chunk.empty?

          words.concat(chunk)

          break if words.size >= 2 && terminators[[words[-2], words[-1]]]
          break if words.join(" ").length > max_length
        end

        words.join(" ")
      end
    end
  end
end
