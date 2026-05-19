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
