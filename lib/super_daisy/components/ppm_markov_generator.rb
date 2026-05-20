# Stage 3 alternative — variable-order Markov generator (PPM-style).
#
# Interface: #call(seed:, corpus:, sampler:, rng:, terminators:, max_length:)
#            -> sentence_string
#
# Behavior: starting from `seed` (chosen externally by SeedSelector), try
# to condition on the last `order` tokens of generated words. If that
# K-gram never appears in the corpus, back off to K-1 tokens, then K-2,
# ..., down to 1. Sample one position uniformly among the matches, emit
# a single next token (stride-1, unlike the classic stride-3 generator).
# Stop on terminator bigram, length cap, or when no continuation exists
# at any order.
#
# Kernel preserved: every emitted token comes verbatim from the corpus.
# Backoff is data-driven, not generative.

module SuperDaisy
  module Components
    class PpmMarkovGenerator
      DEFAULT_ORDER = 4

      attr_reader :order

      def initialize(order: DEFAULT_ORDER)
        raise ArgumentError, "order must be >= 1" if order < 1
        @order = order
      end

      def call(seed:, corpus:, sampler:, rng:, terminators:, max_length:, keywords: nil)
        return "" if seed.nil? || seed.empty?

        words = seed.first(3).dup

        loop do
          nxt = sample_next(corpus, sampler, rng, words)
          break if nxt.nil?

          words << nxt

          break if words.size >= 2 && terminators[[words[-2], words[-1]]]
          break if words.join(" ").length > max_length
        end

        words.join(" ")
      end

      private

      def sample_next(corpus, sampler, rng, words)
        max_k = [@order, words.size].min
        max_k.downto(1) do |k|
          context = words.last(k)
          candidates = corpus.next_tokens_after(context)
          return sampler.call(candidates, rng) unless candidates.empty?
        end
        nil
      end
    end
  end
end
