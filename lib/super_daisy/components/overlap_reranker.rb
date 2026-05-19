# Stage 5 — Candidate reranker.
#
# Interface: #call(candidates) -> winner_sentence_string
#
# `candidates` is Array<[sentence, ugly_flag, overlap_count]>.
#
# Default behavior: pick highest overlap; on ties, prefer non-ugly; final
# tiebreak goes to latest insertion (matches the original's max_by-with-index
# rule, which sweeps and updates on >= rather than >).
#
# Future-fancy alternative: learned-preference reranker. Same input shape;
# the [ov, ugly?, i] tuple becomes a small feature vector scored by a tiny
# linear or MLP reward trained on user feedback.

module SuperDaisy
  module Components
    class OverlapReranker
      def call(candidates)
        return nil if candidates.empty?
        candidates.max_by.with_index { |(_s, ugly, ov), i| [ov, ugly ? 0 : 1, i] }[0]
      end
    end
  end
end
