# Stage 2 alternative — BM25-IDF input-token scorer.
#
# Interface: #call(input_tokens, corpus) -> Array<String>  (keywords)
#
# Treats each sentence in the corpus as one "document" and scores each
# input token by classic Robertson IDF:
#
#   IDF(t) = log((N - n_t + 0.5) / (n_t + 0.5) + 1)
#
# where N = number of sentences in the corpus, n_t = number of sentences
# containing token t (case- and punctuation-insensitive). Returns the
# top-K input tokens by IDF score.
#
# Why "BM25" when we're not actually scoring documents? The IDF half of
# BM25 is the only piece that matters for input-token importance, and
# this matches the spirit of the upgrade described in SUPER_DAISY.md:
# replace the degenerate "rarest input wins" with proper IDF weighting.
# Full BM25 ranking would live in a future reranker, not here.

module SuperDaisy
  module Components
    class BM25Scorer
      DEFAULT_TOP_K = 3

      attr_reader :top_k

      def initialize(top_k: DEFAULT_TOP_K)
        raise ArgumentError, "top_k must be >= 1" if top_k < 1
        @top_k = top_k
      end

      def call(input_tokens, corpus)
        return [] if input_tokens.empty?
        n = corpus.sentences.size
        return input_tokens.first(@top_k) if n.zero?

        scored = input_tokens.map do |t|
          n_t = corpus.sentence_document_frequency(t)
          idf = Math.log(((n - n_t + 0.5) / (n_t + 0.5)) + 1)
          [t, idf]
        end

        # Stable sort: highest IDF first, then preserve input order on ties.
        scored.each_with_index
              .sort_by { |(_t, idf), i| [-idf, i] }
              .first(@top_k)
              .map { |(t, _), _| t }
      end
    end
  end
end
