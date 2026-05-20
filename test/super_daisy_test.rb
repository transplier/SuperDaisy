require "minitest/autorun"
require "tempfile"
require_relative "../lib/daisy"
require_relative "../lib/super_daisy"

# Corpus-builder helper shared across suites below.
def corpus_with(*sentences, klass:)
  tokens = []
  sentences.each { |s| tokens.concat(s.split); tokens << "***" }
  tokens.pop # trailing sentinel stripped on load
  klass.new(tokens: tokens)
end

class SuperDaisyParityTest < Minitest::Test
  # With all-default components, SuperDaisy must produce bit-for-bit the same
  # output as Daisy for the same seed and corpus. This is the load-bearing
  # test of the refactor — if it breaks, we changed behavior.
  def test_parity_with_daisy_under_same_seed
    sentences = [
      "the sky is blue today.",
      "the grass is green here.",
      "i love the platypus very much.",
      "platypus is a unique animal.",
      "hello there friend how are you.",
    ]
    prompts = ["hello there", "tell me about platypus", "the sky"]

    prompts.each do |prompt|
      d_corpus = corpus_with(*sentences, klass: Daisy::Corpus)
      d_bot = Daisy::Bot.new(d_corpus, rng: Random.new(42))
      d_reply = d_bot.respond(prompt, learn: false)

      s_corpus = corpus_with(*sentences, klass: SuperDaisy::Corpus)
      s_bot = SuperDaisy::Bot.new(s_corpus, rng: Random.new(42))
      s_reply = s_bot.respond(prompt, learn: false)

      assert_equal d_reply, s_reply, "drift on prompt: #{prompt.inspect}"
    end
  end
end

class SuperDaisyComponentSwapTest < Minitest::Test
  # Filter that accepts every candidate (overlap=1 unconditionally). Proves
  # the orchestrator routes calls through the filter component.
  class AcceptAllFilter
    def call(_sentence, _kw_set); 1; end
  end

  # Sampler that always picks items.first. Proves every branch decision in
  # the generator flows through the sampler component.
  class FirstItemSampler
    def call(items, _rng); items.first; end
  end

  def make_corpus
    corpus_with(
      "the sky is blue.",
      "the grass is green.",
      "the platypus is curious.",
      klass: SuperDaisy::Corpus,
    )
  end

  def test_swapping_filter_changes_behavior
    default_bot = SuperDaisy::Bot.new(make_corpus, rng: Random.new(7))
    open_bot = SuperDaisy::Bot.new(make_corpus,
                                   filter: AcceptAllFilter.new,
                                   rng: Random.new(7))

    # Use a prompt whose rarest keyword likely won't appear in candidates
    # so the default filter rejects most and the open filter accepts them.
    default_reply = default_bot.respond("a brilliant elephant", learn: false)
    open_reply = open_bot.respond("a brilliant elephant", learn: false)

    refute_equal default_reply, open_reply,
                 "AcceptAllFilter should change candidate selection"
  end

  def test_first_item_sampler_makes_output_seed_independent
    bot_a = SuperDaisy::Bot.new(make_corpus,
                                sampler: FirstItemSampler.new,
                                rng: Random.new(1))
    bot_b = SuperDaisy::Bot.new(make_corpus,
                                sampler: FirstItemSampler.new,
                                rng: Random.new(99999))

    assert_equal bot_a.respond("the sky", learn: false),
                 bot_b.respond("the sky", learn: false),
                 "FirstItemSampler bypasses RNG; outputs must match across seeds"
  end
end

class SuperDaisyInstrumentationTest < Minitest::Test
  def test_last_stats_populated_after_respond
    c = corpus_with("hello world.", "hello there.", klass: SuperDaisy::Corpus)
    bot = SuperDaisy::Bot.new(c, rng: Random.new(0))
    bot.respond("hello", learn: false)
    stats = bot.last_stats
    assert_kind_of Hash, stats
    %i[attempts kept fallthrough ugly].each { |k| assert stats.key?(k), "missing :#{k}" }
    assert_operator stats[:attempts], :>=, 1
  end

  def test_last_stats_records_fallthrough_when_no_match
    # Empty corpus → empty response, no candidates, no real fallthrough either
    # since corpus.empty? short-circuits — record that explicit shape.
    c = SuperDaisy::Corpus.new(tokens: [])
    bot = SuperDaisy::Bot.new(c)
    bot.respond("anything", learn: false)
    assert_equal false, bot.last_stats[:fallthrough]
    assert_equal 0, bot.last_stats[:kept]
  end
end

class SuperDaisyAutoMaxLengthTest < Minitest::Test
  def test_auto_scales_to_mean_sentence_chars
    # Long sentences so the result clears the 40-char floor.
    c = SuperDaisy::Corpus.new(tokens:
      ("aaaaaaaa " * 8 + "***").split + ("bbbbbbbb " * 12 + "***").split)
    cap = SuperDaisy::Bot.auto_max_length(c)
    sents = c.sentences
    mean = sents.sum { |s| s.join(" ").length }.to_f / sents.size
    assert_equal (mean * 1.5).round, cap
    assert_operator cap, :>, 70, "test corpus chosen to exceed the floor"
  end

  def test_auto_uses_floor_on_empty_corpus
    c = SuperDaisy::Corpus.new(tokens: [])
    assert_equal 70, SuperDaisy::Bot.auto_max_length(c)
  end

  def test_bot_picks_auto_when_max_length_omitted
    c = SuperDaisy::Corpus.new(tokens: %w[one two three four five six. ***])
    bot = SuperDaisy::Bot.new(c)
    assert_equal SuperDaisy::Bot.auto_max_length(c), bot.max_length
  end

  def test_bot_respects_explicit_max_length
    c = SuperDaisy::Corpus.new(tokens: %w[one two three four five six. ***])
    bot = SuperDaisy::Bot.new(c, max_length: 999)
    assert_equal 999, bot.max_length
  end
end

class SuperDaisyUglyTest < Minitest::Test
  def test_cyclic_detects_aba_pattern
    assert SuperDaisy::Ugly.cyclic?(%w[the cat the])
    assert SuperDaisy::Ugly.cyclic?(%w[foo bar baz bar baz])  # ABA at i=4 with B-A-B
    refute SuperDaisy::Ugly.cyclic?(%w[the quick brown fox])
    refute SuperDaisy::Ugly.cyclic?(%w[a b])               # too short
    refute SuperDaisy::Ugly.cyclic?([])
  end

  def test_over_length_uses_string_length
    assert SuperDaisy::Ugly.over_length?("x" * 71, 70)
    refute SuperDaisy::Ugly.over_length?("x" * 70, 70)
  end

  def test_judge_combines_length_and_cycle
    assert SuperDaisy::Ugly.judge("the cat the dog", max_length: 70)  # ABA
    assert SuperDaisy::Ugly.judge("x" * 80, max_length: 70)            # too long
    refute SuperDaisy::Ugly.judge("a clean short response.", max_length: 70)
    refute SuperDaisy::Ugly.judge("", max_length: 70)                  # empty
  end
end

class SuperDaisySVDTest < Minitest::Test
  # Find the top eigenpair of a known symmetric matrix and check the
  # Rayleigh quotient. Power iteration is iterative; we allow tolerance.
  def test_truncated_eigh_recovers_top_eigenvector_of_simple_matrix
    # 2x2: [[2, 1], [1, 2]]. Eigenvalues: 3 and 1.
    sparse = [
      [[0, 2.0], [1, 1.0]],
      [[0, 1.0], [1, 2.0]],
    ]
    eigvals, eigvecs = SuperDaisy::SVD.call(sparse, k: 2, iters: 50, rng: Random.new(1))
    top = eigvals.max
    assert_in_delta 3.0, top, 0.01
    # The top eigenvector should be ~[1/√2, 1/√2] (or its negative).
    top_idx = eigvals.index(top)
    v = eigvecs[top_idx]
    assert_in_delta (1.0 / Math.sqrt(2)).abs, v[0].abs, 0.05
    assert_in_delta (1.0 / Math.sqrt(2)).abs, v[1].abs, 0.05
  end

  def test_truncated_eigh_handles_empty_matrix
    eigvals, eigvecs = SuperDaisy::SVD.call([], k: 3, rng: Random.new(0))
    assert_empty eigvals
    assert_empty eigvecs
  end
end

class SuperDaisySemanticEmbeddingsTest < Minitest::Test
  # Two related words ("cat" and "dog" appearing in similar contexts)
  # should have higher cosine similarity than two unrelated ones.
  def test_embeddings_capture_distributional_similarity
    # Cat and dog appear in very similar contexts; spaceship in a
    # disjoint one. With enough sentences PPMI+SVD should reflect that.
    pet_lines = [
      "the cat sat on the mat",
      "the dog sat on the mat",
      "the cat ate the food",
      "the dog ate the food",
      "i love my cat",
      "i love my dog",
      "the cat slept on the bed",
      "the dog slept on the bed",
      "the cat watched the bird",
      "the dog watched the bird",
      "a cat purred quietly",
      "a dog barked loudly",
      "a cat chased the ball",
      "a dog chased the ball",
    ]
    ship_lines = [
      "the spaceship orbited the planet",
      "the spaceship landed on the moon",
      "the spaceship traveled through the void",
      "an alien piloted the spaceship",
      "the spaceship docked at the station",
      "a damaged spaceship drifted in space",
    ]
    tokens = []
    (pet_lines + ship_lines).each { |s| tokens.concat(s.split); tokens << "***" }
    c = SuperDaisy::Corpus.new(tokens: tokens)

    opts = { dims: 16, min_count: 2, seed: 1 }
    cat = c.word_embedding("cat", **opts)
    dog = c.word_embedding("dog", **opts)
    ship = c.word_embedding("spaceship", **opts)
    refute_nil cat
    refute_nil dog
    refute_nil ship

    sim_cat_dog = cosine(cat, dog)
    sim_cat_ship = cosine(cat, ship)
    assert_operator sim_cat_dog, :>, sim_cat_ship,
                    "cat-dog should be more similar than cat-spaceship; " \
                    "got #{sim_cat_dog.round(3)} vs #{sim_cat_ship.round(3)}"
  end

  def test_below_min_count_words_have_no_embedding
    c = SuperDaisy::Corpus.new(tokens: %w[
      the cat sat. ***
      the dog sat. ***
      the cat ran. ***
      raredog appeared once.
    ])
    # "raredog" appears once; with min_count=2 it's excluded.
    assert_nil c.word_embedding("raredog", dims: 4, min_count: 2, seed: 0)
    refute_nil c.word_embedding("cat", dims: 4, min_count: 2, seed: 0)
  end

  def test_sentence_embeddings_returns_vector_per_sentence
    c = SuperDaisy::Corpus.new(tokens: %w[
      hello world. ***
      hello there. ***
      goodbye world.
    ])
    vecs = c.sentence_embeddings(dims: 4, min_count: 1, seed: 0)
    assert_equal 3, vecs.size
    vecs.each { |v| assert_equal 4, v.size }
  end

  private

  def cosine(a, b)
    na = Math.sqrt(a.sum { |x| x * x })
    nb = Math.sqrt(b.sum { |x| x * x })
    return 0 if na < 1e-12 || nb < 1e-12
    dot = 0.0
    a.each_with_index { |x, i| dot += x * b[i] }
    dot / (na * nb)
  end
end

class SuperDaisyCorpusIndexTest < Minitest::Test
  def test_next_tokens_after_returns_continuations_within_sentence
    c = SuperDaisy::Corpus.new(tokens: %w[a b c *** a b d *** a b])
    assert_equal %w[c d], c.next_tokens_after(%w[a b])
    assert_equal %w[b b b], c.next_tokens_after(%w[a])
    # 'b' at the end of a sentence has no in-sentence successor.
    assert_equal %w[c d], c.next_tokens_after(%w[b])
    # Empty context returns empty.
    assert_equal [], c.next_tokens_after([])
    # Unseen context returns empty.
    assert_equal [], c.next_tokens_after(%w[x y])
  end

  def test_ngram_index_invalidated_on_learn
    c = SuperDaisy::Corpus.new(tokens: %w[a b c ***])
    assert_equal %w[c], c.next_tokens_after(%w[a b])
    c.learn(%w[a b d])
    assert_equal %w[c d], c.next_tokens_after(%w[a b])
  end

  def test_sentence_document_frequency_counts_sentences_containing_token
    # "the" appears in 2 sentences (twice in one but the per-sentence seen
    # guard means it still counts as 1 there); "platypus" in 1; "ferret" in 0.
    c = SuperDaisy::Corpus.new(tokens: %w[
      the cat the. ***
      the dog ran. ***
      a brilliant platypus. ***
      hello world.
    ])
    assert_equal 2, c.sentence_document_frequency("the")
    assert_equal 1, c.sentence_document_frequency("platypus")
    assert_equal 0, c.sentence_document_frequency("ferret")
  end

  def test_sentence_df_invalidated_on_learn
    c = SuperDaisy::Corpus.new(tokens: %w[the cat ***])
    assert_equal 1, c.sentence_document_frequency("the")
    c.learn(%w[the dog])
    assert_equal 2, c.sentence_document_frequency("the")
  end
end

class SuperDaisyComponentContractTest < Minitest::Test
  def test_whitespace_tokenizer
    t = SuperDaisy::Components::WhitespaceTokenizer.new
    assert_equal ["hello", "world."], t.call("Hello world")
    assert_equal ["hi!"], t.call("hi!")
    assert_equal [], t.call("")
  end

  def test_rarest_word_scorer
    c = corpus_with("the the the.", "the cat sat.", klass: SuperDaisy::Corpus)
    s = SuperDaisy::Components::RarestWordScorer.new
    # "cat" appears once, "the" appears four times — cat is rarest.
    kws = s.call(%w[the cat], c)
    assert_equal ["cat"], kws
  end

  def test_bm25_scorer_ranks_input_tokens_by_idf
    c = corpus_with(
      "the sky is blue.", "the grass is green.", "the dog ran fast.",
      "a curious platypus.", "the platypus appeared.",
      klass: SuperDaisy::Corpus,
    )
    s = SuperDaisy::Components::BM25Scorer.new(top_k: 2)
    # "the" is in 4/5 sentences (low IDF); "platypus" in 2/5;
    # "elephant" in 0/5 (highest IDF). Top 2 should be elephant then platypus.
    kws = s.call(%w[the platypus elephant], c)
    assert_equal %w[elephant platypus], kws
  end

  def test_bm25_scorer_returns_at_most_top_k
    c = corpus_with("the cat.", klass: SuperDaisy::Corpus)
    s = SuperDaisy::Components::BM25Scorer.new(top_k: 2)
    assert_equal 2, s.call(%w[a b c d e], c).size
  end

  def test_bm25_scorer_handles_empty_corpus
    c = SuperDaisy::Corpus.new(tokens: [])
    s = SuperDaisy::Components::BM25Scorer.new(top_k: 3)
    # No NaN, no crash — just return up to top_k input tokens as-is.
    assert_equal %w[a b c], s.call(%w[a b c d], c)
  end

  def test_build_scorer_helper
    assert_kind_of SuperDaisy::Components::RarestWordScorer,
                   SuperDaisy::Components.build_scorer(nil)
    assert_kind_of SuperDaisy::Components::RarestWordScorer,
                   SuperDaisy::Components.build_scorer("classic")
    assert_kind_of SuperDaisy::Components::BM25Scorer,
                   SuperDaisy::Components.build_scorer("bm25")
    bm25_5 = SuperDaisy::Components.build_scorer("bm25:5")
    assert_equal 5, bm25_5.top_k
    assert_raises(ArgumentError) { SuperDaisy::Components.build_scorer("nope") }
  end

  def test_uniform_sampler_picks_from_items
    s = SuperDaisy::Components::UniformSampler.new
    picked = s.call([10, 20, 30], Random.new(0))
    assert_includes [10, 20, 30], picked
  end

  def test_temperature_sampler_t1_matches_uniform_distribution
    # 1000 draws of a multiset; T=1 should preserve raw frequencies.
    items = %i[a a a b]  # 75% a, 25% b
    s = SuperDaisy::Components::TemperatureSampler.new(temperature: 1.0)
    rng = Random.new(42)
    counts = Hash.new(0)
    1000.times { counts[s.call(items, rng)] += 1 }
    # Allow generous tolerance — sampling noise is real with 1k draws.
    assert_in_delta 0.75, counts[:a] / 1000.0, 0.05
  end

  def test_temperature_sampler_low_t_concentrates_on_mode
    # T<<1 should push almost all mass to the most-frequent item.
    items = %i[a a a b]
    s = SuperDaisy::Components::TemperatureSampler.new(temperature: 0.1)
    rng = Random.new(42)
    counts = Hash.new(0)
    1000.times { counts[s.call(items, rng)] += 1 }
    assert_operator counts[:a], :>, 950, "low T should concentrate on the mode"
  end

  def test_temperature_sampler_high_t_flattens
    # T>>1 should flatten toward uniform-over-unique.
    items = %i[a a a b]
    s = SuperDaisy::Components::TemperatureSampler.new(temperature: 10.0)
    rng = Random.new(42)
    counts = Hash.new(0)
    1000.times { counts[s.call(items, rng)] += 1 }
    # b's share should rise noticeably from 25% baseline.
    assert_operator counts[:b] / 1000.0, :>, 0.35,
                    "high T should give rarer items more mass"
  end

  def test_temperature_sampler_handles_singleton
    s = SuperDaisy::Components::TemperatureSampler.new(temperature: 0.5)
    assert_equal :only, s.call([:only], Random.new(0))
  end

  def test_build_sampler_helper
    assert_kind_of SuperDaisy::Components::UniformSampler,
                   SuperDaisy::Components.build_sampler(nil)
    assert_kind_of SuperDaisy::Components::UniformSampler,
                   SuperDaisy::Components.build_sampler("uniform")
    t = SuperDaisy::Components.build_sampler("temperature:0.5")
    assert_kind_of SuperDaisy::Components::TemperatureSampler, t
    assert_in_delta 0.5, t.temperature, 1e-9
    assert_raises(ArgumentError) { SuperDaisy::Components.build_sampler("nope") }
    assert_raises(ArgumentError) { SuperDaisy::Components::TemperatureSampler.new(temperature: 0) }
  end

  def test_stride_three_markov_generator_returns_string
    c = corpus_with("hello world.", "hello there.", klass: SuperDaisy::Corpus)
    g = SuperDaisy::Components::StrideThreeMarkovGenerator.new
    sentence = g.call(seed: c.sentences.first,
                      corpus: c,
                      sampler: SuperDaisy::Components::UniformSampler.new,
                      rng: Random.new(0),
                      terminators: c.terminator_bigrams,
                      max_length: 70)
    assert_kind_of String, sentence
    refute_empty sentence
  end

  def test_generator_returns_empty_on_empty_seed
    c = corpus_with("hello world.", klass: SuperDaisy::Corpus)
    g = SuperDaisy::Components::StrideThreeMarkovGenerator.new
    assert_equal "", g.call(seed: [], corpus: c,
                            sampler: SuperDaisy::Components::UniformSampler.new,
                            rng: Random.new(0),
                            terminators: c.terminator_bigrams,
                            max_length: 70)
  end

  def test_ppm_generator_returns_string_and_emits_corpus_tokens
    c = corpus_with("hello world today.",
                    "hello there friend.",
                    "the quick brown fox.",
                    klass: SuperDaisy::Corpus)
    g = SuperDaisy::Components::PpmMarkovGenerator.new(order: 3)
    sentence = g.call(seed: c.sentences.first,
                      corpus: c,
                      sampler: SuperDaisy::Components::UniformSampler.new,
                      rng: Random.new(0),
                      terminators: c.terminator_bigrams,
                      max_length: 70)
    assert_kind_of String, sentence
    refute_empty sentence
    sentence.split.each do |t|
      assert_includes c.tokens, t, "PPM emitted non-corpus token: #{t.inspect}"
    end
  end

  def test_ppm_high_order_recites_from_corpus
    c = corpus_with("the only sentence she has ever seen.",
                    klass: SuperDaisy::Corpus)
    g = SuperDaisy::Components::PpmMarkovGenerator.new(order: 5)
    sentence = g.call(seed: c.sentences.first,
                      corpus: c,
                      sampler: SuperDaisy::Components::UniformSampler.new,
                      rng: Random.new(1),
                      terminators: c.terminator_bigrams,
                      max_length: 70)
    assert_equal "the only sentence she has ever seen.", sentence
  end

  def test_ppm_backs_off_when_high_order_context_is_missing
    c = corpus_with("hello world today is good.",
                    "today brings new beginnings.",
                    "hello friend.",
                    klass: SuperDaisy::Corpus)
    g = SuperDaisy::Components::PpmMarkovGenerator.new(order: 4)
    sampler = SuperDaisy::Components::UniformSampler.new
    5.times do |i|
      rng = Random.new(i)
      seed = sampler.call(c.sentences, rng)
      sentence = g.call(seed: seed, corpus: c, sampler: sampler, rng: rng,
                        terminators: c.terminator_bigrams, max_length: 70)
      refute_empty sentence
    end
  end

  def test_keyword_presence_filter_returns_count
    f = SuperDaisy::Components::KeywordPresenceFilter.new
    kw_set = { "cat" => true, "dog" => true }
    assert_equal 0, f.call("the sky is blue", kw_set)
    assert_equal 1, f.call("a cat appeared", kw_set)
    assert_equal 2, f.call("a cat and a dog", kw_set)
    # Empty kw_set: contract says overlap=0 (orchestrator interprets as accept).
    assert_equal 0, f.call("anything goes", {})
  end

  def test_overlap_reranker_picks_highest_overlap
    r = SuperDaisy::Components::OverlapReranker.new
    candidates = [
      ["low", false, 1],
      ["high", false, 5],
      ["mid", false, 3],
    ]
    assert_equal "high", r.call(candidates)
    assert_nil r.call([])
  end

  def test_overlap_reranker_tie_break_prefers_non_ugly
    r = SuperDaisy::Components::OverlapReranker.new
    candidates = [
      ["ugly_one", true, 3],
      ["clean_one", false, 3],
    ]
    assert_equal "clean_one", r.call(candidates)
  end

  def test_density_reranker_prefers_denser_on_same_overlap
    r = SuperDaisy::Components::DensityReranker.new
    candidates = [
      ["alpha beta gamma delta epsilon zeta", false, 1],  # 1/6
      ["alpha beta", false, 1],                            # 1/2 (denser)
    ]
    assert_equal "alpha beta", r.call(candidates)
  end

  def test_density_reranker_still_prefers_higher_overlap
    r = SuperDaisy::Components::DensityReranker.new
    candidates = [
      ["short one", false, 1],         # 1/2 = 0.5
      ["a longer six word one", false, 3],  # 3/5 = 0.6
    ]
    assert_equal "a longer six word one", r.call(candidates)
  end

  def test_density_reranker_handles_empty
    assert_nil SuperDaisy::Components::DensityReranker.new.call([])
  end

  def test_build_reranker_helper
    assert_kind_of SuperDaisy::Components::OverlapReranker,
                   SuperDaisy::Components.build_reranker(nil)
    assert_kind_of SuperDaisy::Components::DensityReranker,
                   SuperDaisy::Components.build_reranker("density")
    assert_raises(ArgumentError) { SuperDaisy::Components.build_reranker("nope") }
  end

  def test_uniform_seed_selector_returns_a_corpus_sentence
    c = corpus_with("alpha beta.", "gamma delta.", klass: SuperDaisy::Corpus)
    s = SuperDaisy::Components::UniformSeedSelector.new
    seed = s.call(c, SuperDaisy::Components::UniformSampler.new, Random.new(0), keywords: %w[unused])
    assert_includes c.sentences, seed
  end

  def test_keyword_seed_selector_biases_toward_keyword_sentences
    c = corpus_with(
      "the sky is blue.",
      "the grass is green.",
      "i love the platypus very much.",
      "platypus is a unique animal.",
      klass: SuperDaisy::Corpus,
    )
    s = SuperDaisy::Components::KeywordSeedSelector.new
    sampler = SuperDaisy::Components::UniformSampler.new

    # 50 draws with keyword=[platypus]: should always land in a sentence
    # that contains "platypus".
    50.times do |i|
      seed = s.call(c, sampler, Random.new(i), keywords: %w[platypus])
      assert_includes seed.join(" "), "platypus", "seed #{i}: #{seed.inspect}"
    end
  end

  def test_keyword_seed_selector_falls_back_to_uniform_when_no_match
    c = corpus_with("alpha beta.", "gamma delta.", klass: SuperDaisy::Corpus)
    s = SuperDaisy::Components::KeywordSeedSelector.new
    seed = s.call(c, SuperDaisy::Components::UniformSampler.new, Random.new(0),
                  keywords: %w[absent])
    assert_includes c.sentences, seed
  end

  def test_build_seed_selector_helper
    assert_kind_of SuperDaisy::Components::UniformSeedSelector,
                   SuperDaisy::Components.build_seed_selector(nil)
    assert_kind_of SuperDaisy::Components::KeywordSeedSelector,
                   SuperDaisy::Components.build_seed_selector("keyword")
    assert_kind_of SuperDaisy::Components::SemanticSeedSelector,
                   SuperDaisy::Components.build_seed_selector("semantic")
    semantic32 = SuperDaisy::Components.build_seed_selector("semantic:32")
    assert_equal 32, semantic32.dims
    assert_raises(ArgumentError) { SuperDaisy::Components.build_seed_selector("nope") }
  end

  def test_semantic_seed_selector_returns_a_corpus_sentence
    c = corpus_with(
      "the cat sat on the mat.",
      "the dog sat on the mat.",
      "the spaceship orbited the planet.",
      "a cat purred quietly.",
      klass: SuperDaisy::Corpus,
    )
    s = SuperDaisy::Components::SemanticSeedSelector.new(dims: 8, min_count: 1, top_n: 3)
    seed = s.call(c, SuperDaisy::Components::UniformSampler.new, Random.new(0), keywords: %w[cat])
    assert_includes c.sentences, seed
  end

  def test_semantic_seed_selector_falls_back_when_keywords_have_no_embeddings
    c = corpus_with("alpha beta gamma.", klass: SuperDaisy::Corpus)
    s = SuperDaisy::Components::SemanticSeedSelector.new(dims: 4, min_count: 1)
    seed = s.call(c, SuperDaisy::Components::UniformSampler.new, Random.new(0), keywords: %w[absent])
    assert_includes c.sentences, seed
  end

  def test_last_turn_memory_carry_and_record
    m = SuperDaisy::Components::LastTurnMemory.new
    assert_equal [], m.carry
    m.record(%w[foo bar])
    assert_equal %w[foo bar], m.carry
    m.record(%w[baz])
    assert_equal %w[baz], m.carry
  end
end
