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

  def test_uniform_sampler_picks_from_items
    s = SuperDaisy::Components::UniformSampler.new
    picked = s.call([10, 20, 30], Random.new(0))
    assert_includes [10, 20, 30], picked
  end

  def test_stride_three_markov_generator_returns_pair
    c = corpus_with("hello world.", "hello there.", klass: SuperDaisy::Corpus)
    g = SuperDaisy::Components::StrideThreeMarkovGenerator.new
    sentence, ugly = g.call(corpus: c,
                            sampler: SuperDaisy::Components::UniformSampler.new,
                            rng: Random.new(0),
                            terminators: c.terminator_bigrams,
                            max_length: 70)
    assert_kind_of String, sentence
    refute_empty sentence
    assert_includes [true, false], ugly
  end

  def test_ppm_generator_returns_pair_and_emits_corpus_tokens
    c = corpus_with("hello world today.",
                    "hello there friend.",
                    "the quick brown fox.",
                    klass: SuperDaisy::Corpus)
    g = SuperDaisy::Components::PpmMarkovGenerator.new(order: 3)
    sentence, ugly = g.call(corpus: c,
                            sampler: SuperDaisy::Components::UniformSampler.new,
                            rng: Random.new(0),
                            terminators: c.terminator_bigrams,
                            max_length: 70)
    assert_kind_of String, sentence
    refute_empty sentence
    sentence.split.each do |t|
      assert_includes c.tokens, t, "PPM emitted non-corpus token: #{t.inspect}"
    end
    assert_includes [true, false], ugly
  end

  def test_ppm_high_order_recites_from_corpus
    # Single sentence corpus; order-5 PPM has nowhere to go but recite it.
    c = corpus_with("the only sentence she has ever seen.",
                    klass: SuperDaisy::Corpus)
    g = SuperDaisy::Components::PpmMarkovGenerator.new(order: 5)
    sentence, _ = g.call(corpus: c,
                         sampler: SuperDaisy::Components::UniformSampler.new,
                         rng: Random.new(1),
                         terminators: c.terminator_bigrams,
                         max_length: 70)
    assert_equal "the only sentence she has ever seen.", sentence
  end

  def test_ppm_backs_off_when_high_order_context_is_missing
    # A corpus where 3-gram "hello world today" is unique but the bigram
    # "world today" doesn't appear elsewhere — order=4 backs off through 3, 2, 1.
    c = corpus_with("hello world today is good.",
                    "today brings new beginnings.",
                    "hello friend.",
                    klass: SuperDaisy::Corpus)
    g = SuperDaisy::Components::PpmMarkovGenerator.new(order: 4)
    # Run a few times; if backoff is broken we'd see empty sentences or crashes.
    5.times do |i|
      sentence, _ = g.call(corpus: c,
                           sampler: SuperDaisy::Components::UniformSampler.new,
                           rng: Random.new(i),
                           terminators: c.terminator_bigrams,
                           max_length: 70)
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

  def test_last_turn_memory_carry_and_record
    m = SuperDaisy::Components::LastTurnMemory.new
    assert_equal [], m.carry
    m.record(%w[foo bar])
    assert_equal %w[foo bar], m.carry
    m.record(%w[baz])
    assert_equal %w[baz], m.carry
  end
end
