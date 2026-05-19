# Stage 4 — Candidate filter / overlap scorer.
#
# Interface: #call(sentence, kw_set) -> Integer overlap_count
#
# `kw_set` is a Hash<cleaned_lowercase_keyword, true> built once per
# best_response by the orchestrator. Returning an Int (vs. Bool) lets the
# orchestrator reuse the count for the reranker without recomputing.
#
# The orchestrator interprets the result: when kw_set is empty, accept all
# candidates (with overlap=0); otherwise accept iff overlap > 0.
#
# Future-fancy alternative: soft logit-bias / FUDGE-style classifier guidance
# operating on the rerank score rather than rejecting candidates outright.

module SuperDaisy
  module Components
    class KeywordPresenceFilter
      def call(sentence, kw_set)
        return 0 if kw_set.empty?
        count = 0
        sentence.split(/\s+/).each do |t|
          count += 1 if kw_set[SuperDaisy::Corpus.clean(t).downcase]
        end
        count
      end
    end
  end
end
