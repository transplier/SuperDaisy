# Stage 3 — Candidate sentence generator.
#
# Interface: #call(corpus:, sampler:, rng:, terminators:, max_length:)
#            -> sentence_string
#
# Default behavior: pick a sentence start uniformly, then 1st-order Markov
# walk with stride-3 emission. Every random choice goes through the sampler.
# Returns when the trailing bigram is a known sentence-ender, when the walk
# falls off the corpus, or when the sentence exceeds max_length.
#
# Ugly-flag detection lives in SuperDaisy::Ugly and is run by the Bot
# orchestrator on the returned sentence — same heuristic for every
# generator, so the eval metric is comparable across them.

module SuperDaisy
  module Components
    class StrideThreeMarkovGenerator
      def call(corpus:, sampler:, rng:, terminators:, max_length:)
        sents = corpus.sentences
        return "" if sents.empty?

        seed = sampler.call(sents, rng)
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
