# Stage 3a alternative — semantic prompt-aware seed selector.
#
# Like KeywordSeedSelector, but generalizes "contains literal keyword" to
# "highest cosine similarity to the prompt centroid" using PPMI+SVD
# embeddings computed once from the corpus itself. No external data.
#
# Caveat: the SVD step IS a fit step (deterministic, no gradient descent).
# Per SUPER_DAISY.md this puts the component in the kernel "gray zone".
# Worth measuring as a future-tech demonstration; not recommended as
# default until we decide on the policy.
#
# Interface: #call(corpus, sampler, rng, keywords:) -> Array<String> | nil
#
# Behavior:
# 1. Compute prompt centroid = mean of in-vocab keyword embeddings.
# 2. Score each sentence by cosine similarity to the prompt centroid.
# 3. Take top_n highest-scoring sentences; sample uniformly from those.
# 4. Falls back to uniform random when no keyword has an embedding.

module SuperDaisy
  module Components
    class SemanticSeedSelector
      DEFAULT_DIMS = 50
      DEFAULT_WINDOW = 5
      DEFAULT_MIN_COUNT = 2
      DEFAULT_TOP_N = 25
      DEFAULT_SEED = 0

      attr_reader :dims, :window, :min_count, :top_n, :embedding_seed

      def initialize(dims: DEFAULT_DIMS, window: DEFAULT_WINDOW,
                     min_count: DEFAULT_MIN_COUNT, top_n: DEFAULT_TOP_N,
                     embedding_seed: DEFAULT_SEED)
        @dims = dims
        @window = window
        @min_count = min_count
        @top_n = top_n
        @embedding_seed = embedding_seed
      end

      def call(corpus, sampler, rng, keywords: [])
        sents = corpus.sentences
        return nil if sents.empty?
        return sampler.call(sents, rng) if keywords.empty?

        # Same keywords are passed repeatedly during one best_response's
        # rejection loop. Memoize the (corpus, keywords) → top-N indices
        # mapping so the O(num_sentences × dims) similarity scan runs once.
        cache_key = [corpus.object_id, keywords]
        top_indices = nil
        if @last_key == cache_key
          top_indices = @last_top
        else
          top_indices = compute_top_indices(corpus, keywords)
          @last_key = cache_key
          @last_top = top_indices
        end

        return sampler.call(sents, rng) if top_indices.nil? || top_indices.empty?
        chosen = sampler.call(top_indices, rng)
        sents[chosen]
      end

      private

      def compute_top_indices(corpus, keywords)
        embeds = keywords.map { |k| corpus.word_embedding(k, **embed_opts) }.compact
        return nil if embeds.empty?

        centroid = Array.new(@dims, 0.0)
        embeds.each do |e|
          e.each_with_index { |x, i| centroid[i] += x }
        end
        centroid.map! { |x| x / embeds.size }
        cnorm = norm(centroid)
        return nil if cnorm < 1e-12
        centroid.map! { |x| x / cnorm }

        sent_vecs = corpus.sentence_embeddings(**embed_opts)
        scored = sent_vecs.each_with_index.map do |sv, i|
          n = norm(sv)
          sim = n < 1e-12 ? 0.0 : dot(centroid, sv) / n
          [sim, i]
        end
        scored.sort_by { |sim, _| -sim }.first(@top_n).map { |_, i| i }
      end

      def embed_opts
        { dims: @dims, window: @window, min_count: @min_count, seed: @embedding_seed }
      end

      def dot(a, b)
        s = 0.0
        a.each_with_index { |x, i| s += x * b[i] }
        s
      end

      def norm(v)
        Math.sqrt(v.sum { |x| x * x })
      end
    end
  end
end
