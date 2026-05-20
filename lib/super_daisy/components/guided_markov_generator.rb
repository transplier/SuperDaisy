# Stage 3 alternative — semantically guided Markov generator.
#
# Interface: #call(seed:, corpus:, sampler:, rng:, terminators:, max_length:, keywords:)
#            -> sentence_string
#
# Stride-1 1st-order Markov walker that biases each branch decision toward
# candidates which keep the running utterance close to the prompt centroid
# in PPMI+SVD embedding space.
#
# Per-step weight for candidate w:
#   weight(w) = count(w) · exp(α · cos(centroid(so_far + w), prompt_centroid))
#
# At α=0 this reduces to uniform-over-multiset (= raw frequency weighting),
# i.e. equivalent to PPM:1 with the uniform sampler. As α grows the topical
# pull strengthens.
#
# Key property: the bias decays naturally with sentence length. The centroid
# is the mean of token embeddings, so adding one more token to a long
# so_far barely moves it; late-sentence steps are essentially free Markov
# walks. Early-sentence steps carry strong topical commitment. This is
# what gives the walker room to drift into DAISY's signature non-sequiturs
# in the *tail* of a sentence while opening on-topic.
#
# Kernel position: gray zone. The walker is goal-directed (which we ruled
# out as Option 3 in SUPER_DAISY.md) but with α-tunable strength and the
# growing-centroid decay, the canonical "guided decoding" failure mode is
# mitigated. Worth measuring as a closeout experiment.

module SuperDaisy
  module Components
    class GuidedMarkovGenerator
      DEFAULT_ALPHA = 1.0
      DEFAULT_DIMS = 50
      DEFAULT_WINDOW = 5
      DEFAULT_MIN_COUNT = 2
      DEFAULT_SEED = 0

      attr_reader :alpha, :dims

      def initialize(alpha: DEFAULT_ALPHA, dims: DEFAULT_DIMS,
                     window: DEFAULT_WINDOW, min_count: DEFAULT_MIN_COUNT,
                     embedding_seed: DEFAULT_SEED)
        raise ArgumentError, "alpha must be >= 0" if alpha < 0
        @alpha = alpha
        @dims = dims
        @window = window
        @min_count = min_count
        @embedding_seed = embedding_seed
      end

      def call(seed:, corpus:, sampler:, rng:, terminators:, max_length:, keywords: nil)
        return "" if seed.nil? || seed.empty?

        prompt_centroid = build_prompt_centroid(corpus, keywords)

        words = seed.first(3).dup
        running_sum = Array.new(@dims, 0.0)
        emb_count = 0
        words.each do |w|
          e = embed(corpus, w)
          next unless e
          e.each_with_index { |x, i| running_sum[i] += x }
          emb_count += 1
        end

        loop do
          last = words.last
          positions = corpus.positions_of(last)
          break if positions.empty?

          # Collect next-token candidates (the multiset of tokens that
          # immediately follow `last` somewhere in the corpus).
          candidates = []
          positions.each do |pos|
            nxt = corpus.tokens[pos + 1]
            next if nxt.nil? || nxt == SuperDaisy::SENTINEL
            candidates << nxt
          end
          break if candidates.empty?

          nxt = if prompt_centroid && @alpha > 0
                  sample_biased(candidates, corpus, prompt_centroid,
                                running_sum, emb_count, rng)
                else
                  sampler.call(candidates, rng)
                end

          words << nxt

          e = embed(corpus, nxt)
          if e
            e.each_with_index { |x, i| running_sum[i] += x }
            emb_count += 1
          end

          break if words.size >= 2 && terminators[[words[-2], words[-1]]]
          break if words.join(" ").length > max_length
        end

        words.join(" ")
      end

      private

      def embed_opts
        { dims: @dims, window: @window, min_count: @min_count, seed: @embedding_seed }
      end

      def embed(corpus, word)
        corpus.word_embedding(word, **embed_opts)
      end

      def build_prompt_centroid(corpus, keywords)
        return nil if keywords.nil? || keywords.empty?
        embeds = keywords.map { |k| embed(corpus, k) }.compact
        return nil if embeds.empty?

        centroid = Array.new(@dims, 0.0)
        embeds.each do |e|
          e.each_with_index { |x, i| centroid[i] += x }
        end
        centroid.map! { |x| x / embeds.size }
        n = Math.sqrt(centroid.sum { |x| x * x })
        return nil if n < 1e-12
        centroid.map! { |x| x / n }
      end

      def sample_biased(candidates, corpus, prompt_centroid, running_sum, emb_count, rng)
        counts = Hash.new(0)
        candidates.each { |w| counts[w] += 1 }

        scored = counts.map do |w, count|
          e = embed(corpus, w)
          weight =
            if e
              # Hypothetical centroid: (running_sum + e) / (emb_count + 1).
              # Since prompt_centroid is unit-norm, cos = dot/(|hypo|).
              dot = 0.0
              hypo_norm_sq = 0.0
              e.each_with_index do |x, i|
                h = running_sum[i] + x
                dot += h * prompt_centroid[i]
                hypo_norm_sq += h * h
              end
              sim = hypo_norm_sq < 1e-24 ? 0.0 : dot / Math.sqrt(hypo_norm_sq)
              count * Math.exp(@alpha * sim)
            else
              count.to_f
            end
          [w, weight]
        end

        total = scored.sum { |_, weight| weight }
        return scored.last[0] if total <= 0
        r = rng.rand * total
        cum = 0.0
        scored.each do |w, weight|
          cum += weight
          return w if r < cum
        end
        scored.last[0]
      end
    end
  end
end
