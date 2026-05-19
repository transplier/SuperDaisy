# Stage 2 — Input-token importance scorer.
#
# Interface: #call(input_tokens, corpus) -> Array<String>  (keywords)
#
# Default behavior: degenerate IDF — return all input tokens tied at the
# minimum corpus frequency. Matches the original "Percent" rule.
#
# Future-fancy alternative: BM25, with proper TF, IDF and length norm.

module SuperDaisy
  module Components
    class RarestWordScorer
      def call(input_tokens, corpus)
        return [] if input_tokens.empty?
        freqs = input_tokens.map { |t| [t, corpus.token_frequency(t)] }
        min_freq = freqs.map(&:last).min
        freqs.select { |_, f| f == min_freq }.map(&:first)
      end
    end
  end
end
