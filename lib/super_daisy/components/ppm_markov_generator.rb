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
# Performance note: each step does `corpus.positions_of(context.first)` and
# verifies the full context match per position. For typical corpora and
# orders 3-5 this is cheap; if it becomes a bottleneck we can add a K-gram
# index to the corpus.

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
      # corpus, with multiplicity — so uniform sampling already weights by
      # empirical frequency.
      def next_token_candidates(corpus, context)
        return [] if context.empty?
        anchor = context.first
        k = context.size
        results = []
        corpus.positions_of(anchor).each do |pos|
          next if pos + k > corpus.tokens.size
          match = true
          (1...k).each do |i|
            tok = corpus.tokens[pos + i]
            if tok == SuperDaisy::SENTINEL || tok != context[i]
              match = false
              break
            end
          end
          next unless match
          nxt = corpus.tokens[pos + k]
          next if nxt.nil? || nxt == SuperDaisy::SENTINEL
          results << nxt
        end
        results
      end
    end
  end
end
