# Stage 5 alternative — density-based reranker.
#
# Interface: #call(candidates) -> winner_sentence_string
#
# `candidates` is Array<[sentence, ugly_flag, overlap_count]>.
#
# Default OverlapReranker scores by raw overlap count: a 12-token response
# with 1 keyword scores the same as a 6-token response with 1 keyword.
# DensityReranker scores by overlap / response_length, preferring shorter,
# keyword-denser candidates on the same overlap count. Tiebreak rules
# unchanged: non-ugly preferred, then latest insertion (matching the
# overlap reranker's max_by-with-index behavior).
#
# Costs essentially nothing — one split per candidate at rerank time.

module SuperDaisy
  module Components
    class DensityReranker
      def call(candidates)
        return nil if candidates.empty?
        candidates.max_by.with_index do |(sentence, ugly, ov), i|
          length = [sentence.split(/\s+/).size, 1].max
          [ov.to_f / length, ugly ? 0 : 1, i]
        end[0]
      end
    end
  end
end
