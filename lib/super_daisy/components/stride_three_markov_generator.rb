# Stage 3 — Candidate sentence generator.
#
# Interface: #call(corpus:, sampler:, rng:, terminators:, max_length:)
#            -> [sentence_string, ugly_flag]
#
# Default behavior: pick a sentence start uniformly, then 1st-order Markov
# walk with stride-3 emission. Every random choice goes through the sampler.
# Returns when the trailing bigram is a known sentence-ender, when the walk
# falls off the corpus, or when the sentence exceeds max_length (in which
# case the ugly_flag fires). Also flags local-cycle patterns the same way
# the original's #14 sentinel char did.
#
# Future-fancy alternative: PPM / variable-order Markov with Kneser-Ney
# backoff — walker tries higher-order context first, backs off as needed.

module SuperDaisy
  module Components
    class StrideThreeMarkovGenerator
      def call(corpus:, sampler:, rng:, terminators:, max_length:)
        sents = corpus.sentences
        return ["", false] if sents.empty?

        seed = sampler.call(sents, rng)
        words = seed.first(3).dup
        ugly = false

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

          if words.size >= 3 && chunk.size >= 1
            ugly ||= chunk[0] == words[-2]
            ugly ||= chunk.size >= 2 && chunk[1] == words[-1]
            ugly ||= chunk.size >= 3 && chunk[2] == chunk[0]
          end

          words.concat(chunk)

          if words.size >= 2 && terminators[[words[-2], words[-1]]]
            break
          end

          if words.join(" ").length > max_length
            ugly = true
            break
          end
        end

        [words.join(" "), ugly]
      end
    end
  end
end
