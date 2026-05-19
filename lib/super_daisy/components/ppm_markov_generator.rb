# Stage 3 alternative — variable-order Markov generator (PPM-style).
#
# Interface: #call(corpus:, sampler:, rng:, terminators:, max_length:)
#            -> [sentence_string, ugly_flag]
#
# Behavior: try to condition on the last `order` tokens of generated words.
# If that K-gram never appears in the corpus, back off to K-1 tokens, then
# K-2, ..., down to 1. Sample one position uniformly among the matches,
# emit a single next token (stride-1, unlike the classic stride-3
# generator), repeat. Stop on terminator bigram, length cap, or when no
# continuation exists at any order.
#
# Kernel preserved: every emitted token comes verbatim from the corpus.
# Backoff is data-driven, not generative. No probability smoothing — we
# treat the corpus as the ground-truth distribution.
#
# Performance note: K-gram lookups are O(1) hash lookups via the corpus's
# `next_tokens_after` index, lazily built per order and invalidated on
# learn(). Per-step cost is independent of corpus size.

module SuperDaisy
  module Components
    class PpmMarkovGenerator
      DEFAULT_ORDER = 4

      attr_reader :order

      def initialize(order: DEFAULT_ORDER)
        raise ArgumentError, "order must be >= 1" if order < 1
        @order = order
      end

      def call(corpus:, sampler:, rng:, terminators:, max_length:)
        sents = corpus.sentences
        return ["", false] if sents.empty?

        seed = sampler.call(sents, rng)
        words = seed.first(3).dup
        ugly = false

        loop do
          nxt = sample_next(corpus, sampler, rng, words)
          break if nxt.nil?

          # Local-cycle detection (A-B-A): mirrors the classic generator's
          # equivalent ugly-flag check, adapted for stride-1 emission.
          ugly ||= words.size >= 2 && nxt == words[-2]

          words << nxt

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

      private

      # Pick the next token by trying decreasing context lengths until one
      # has matches in the corpus, then sampling among them.
      def sample_next(corpus, sampler, rng, words)
        max_k = [@order, words.size].min
        max_k.downto(1) do |k|
          context = words.last(k)
          candidates = next_token_candidates(corpus, context)
          return sampler.call(candidates, rng) unless candidates.empty?
        end
        nil
      end

      # Every token that immediately follows `context` somewhere in the
      # corpus, with multiplicity. Delegates to the corpus's K-gram index.
      def next_token_candidates(corpus, context)
        corpus.next_tokens_after(context)
      end
    end
  end
end
