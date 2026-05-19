require "minitest/autorun"
require "tempfile"
require_relative "../lib/daisy"

class CorpusTest < Minitest::Test
  def make_dsy(content)
    f = Tempfile.new(["mem", ".dsy"])
    f.write(content)
    f.close
    f.path
  end

  def test_round_trip
    path = make_dsy(<<~DSY)
      Daisy
      1
      hello
      world.
      ***
      foo
      bar.
      ***
    DSY

    c = Daisy::Corpus.load(path)
    assert_equal "Daisy", c.bot_name
    assert_equal true, c.learn_mode
    assert_equal %w[hello world. *** foo bar.], c.tokens

    out = Tempfile.new(["out", ".dsy"]).path
    c.save(out)
    c2 = Daisy::Corpus.load(out)
    assert_equal c.bot_name, c2.bot_name
    assert_equal c.learn_mode, c2.learn_mode
    assert_equal c.tokens, c2.tokens
  end

  def test_learn_appends_tokens_and_sentinel
    c = Daisy::Corpus.new
    c.learn(%w[hello world.])
    assert_equal %w[hello world. ***], c.tokens
  end

  def test_clean_strips_punctuation
    assert_equal "hello", Daisy::Corpus.clean("hello,")
    assert_equal "hello", Daisy::Corpus.clean("(hello)!")
    assert_equal "abc", Daisy::Corpus.clean(';!()/\\:"a,b.c?')
  end

  def test_token_frequency_case_and_punct_insensitive
    c = Daisy::Corpus.new(tokens: %w[The the THE, cat. *** the dog])
    assert_equal 4, c.token_frequency("the")
    assert_equal 1, c.token_frequency("cat")
    assert_equal 0, c.token_frequency("platypus")
  end

  def test_each_sentence
    c = Daisy::Corpus.new(tokens: %w[a b *** c d e ***])
    assert_equal [%w[a b], %w[c d e]], c.sentences
  end
end

class BotTest < Minitest::Test
  def corpus_with(*sentences)
    tokens = []
    sentences.each { |s| tokens.concat(s.split); tokens << Daisy::SENTINEL }
    Daisy::Corpus.new(tokens: tokens.tap { |t| t.pop }) # trailing sentinel stripped by load
  end

  def test_keywords_picks_rarest_input_tokens
    c = corpus_with("the cat sat.", "the dog ran.", "the the the.")
    bot = Daisy::Bot.new(c, rng: Random.new(42))
    # "the" is everywhere; "platypus" is absent (freq 0, the rarest).
    assert_equal ["platypus"], bot.keywords(%w[the platypus])
  end

  def test_generate_sentence_terminates
    c = corpus_with("hello world.", "hello there friend.", "world is round.")
    bot = Daisy::Bot.new(c, rng: Random.new(0))
    sentence, _ugly = bot.generate_sentence
    refute_empty sentence
    # Should consist only of tokens that appeared in the corpus.
    sentence.split.each do |tok|
      assert_includes c.tokens, tok, "unexpected token: #{tok}"
    end
  end

  def test_best_response_prefers_keyword_bearing_candidate
    c = corpus_with(
      "the sky is blue.",
      "the grass is green.",
      "i love the platypus very much.",
      "platypus is a unique animal."
    )
    bot = Daisy::Bot.new(c, pool_size: 20, rng: Random.new(123))
    # "the" is common, "platypus" is rare — rarest-wins keyword selection picks
    # "platypus", and rejection-sampling should surface a platypus-bearing candidate.
    reply = bot.respond("the platypus.", learn: false)
    refute_empty reply
    assert_includes reply, "platypus"
  end

  def test_best_response_honors_max_candidates_cap
    c = corpus_with("hello world.", "goodbye world.")
    bot = Daisy::Bot.new(c, max_candidates: 1, rng: Random.new(7))
    reply = bot.respond("hello.", learn: false)
    assert_kind_of String, reply
  end

  def test_empty_corpus_does_not_crash
    c = Daisy::Corpus.new(tokens: [])
    bot = Daisy::Bot.new(c)
    assert_equal "", bot.respond("anything", learn: false)
  end

  def test_respond_with_learn_appends_to_corpus
    c = corpus_with("hello world.")
    bot = Daisy::Bot.new(c, rng: Random.new(1))
    size_before = c.tokens.size
    bot.respond("a brand new sentence", learn: true)
    assert_operator c.tokens.size, :>, size_before
    # The new input + sentinel should be present.
    assert_includes c.tokens, "brand"
    assert_equal Daisy::SENTINEL, c.tokens.last
  end
end
