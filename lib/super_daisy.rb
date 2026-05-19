# Super-DAISY: exploratory port of DAISY where modern LM ideas can be plugged
# in without breaking her kernel (she only says what she's seen, learning is
# corpus append, generation is a walk through memory). See SUPER_DAISY.md
# for the design discussion and lib/super_daisy/components/ for the parts.
#
# The Bot is now a thin orchestrator over seven swappable components:
# Tokenizer, Scorer, Generator, Filter, Reranker, Memory, Sampler. With all
# defaults wired in, output is bit-for-bit identical to DAISY for a given
# seed.

module SuperDaisy
  SENTINEL = "***"
  PUNCTUATION = %r{[;!()/\\:",.?]}.freeze
  TERMINAL_PUNCT = /[!.?]\z/.freeze

  # Plaintext .DSY file: line 1 bot name, line 2 learn-mode flag (0/1),
  # remaining lines one token each with '***' sentence separators.
  class Corpus
    attr_accessor :bot_name, :learn_mode
    attr_reader :tokens

    def initialize(bot_name: "Daisy", learn_mode: true, tokens: [])
      @bot_name = bot_name
      @learn_mode = learn_mode
      @tokens = tokens
      invalidate_caches!
    end

    def self.load(path)
      lines = File.readlines(path, chomp: true)
      bot_name = lines.shift || "Daisy"
      learn_mode = (lines.shift == "1")
      tokens = lines
      tokens.pop while tokens.last == SENTINEL
      new(bot_name: bot_name, learn_mode: learn_mode, tokens: tokens)
    end

    def save(path)
      File.open(path, "w") do |f|
        f.puts @bot_name
        f.puts(@learn_mode ? "1" : "0")
        @tokens.each { |t| f.puts t }
      end
    end

    def learn(new_tokens)
      return if new_tokens.empty?
      @tokens.concat(new_tokens)
      @tokens << SENTINEL
      invalidate_caches!
    end

    def token_frequency(word)
      frequency_table[Corpus.clean(word).downcase] || 0
    end

    def frequency_table
      @frequency_cache ||= begin
        table = Hash.new(0)
        @tokens.each do |t|
          next if t == SENTINEL
          table[Corpus.clean(t).downcase] += 1
        end
        table
      end
    end

    def total_word_tokens
      @tokens.count { |t| t != SENTINEL }
    end

    def empty?
      total_word_tokens.zero?
    end

    def each_sentence
      buf = []
      @tokens.each do |t|
        if t == SENTINEL
          yield buf unless buf.empty?
          buf = []
        else
          buf << t
        end
      end
      yield buf unless buf.empty?
    end

    def sentences
      @sentences_cache ||= begin
        result = []
        each_sentence { |s| result << s }
        result
      end
    end

    def positions_of(token)
      positions_index[token] || EMPTY
    end

    # All tokens that immediately follow `context` somewhere in the corpus,
    # with multiplicity (so uniform sampling already weights by empirical
    # frequency). Backed by a lazily-built K-gram index keyed by the size of
    # `context`. Cache is invalidated on learn().
    #
    # Contexts and their following tokens are restricted to within-sentence:
    # we never return a token across a SENTINEL boundary.
    def next_tokens_after(context)
      return EMPTY if context.empty?
      ngram_index(context.size)[context] || EMPTY
    end

    # Number of sentences containing `token` (case- and punctuation-
    # insensitive). The "document frequency" half of an IDF score, where
    # each sentence is one document.
    def sentence_document_frequency(token)
      sentence_df_index[Corpus.clean(token).downcase] || 0
    end

    def terminator_bigrams
      @terminator_cache ||= begin
        set = {}
        sentences.each do |s|
          next if s.size < 2
          set[[s[-2], s[-1]]] = true
        end
        set
      end
    end

    def self.clean(s)
      s.gsub(PUNCTUATION, "")
    end

    private

    EMPTY = [].freeze

    def positions_index
      @positions_cache ||= begin
        h = {}
        @tokens.each_with_index do |t, i|
          next if t == SENTINEL
          (h[t] ||= []) << i
        end
        h
      end
    end

    def ngram_index(k)
      @ngram_cache ||= {}
      @ngram_cache[k] ||= begin
        h = {}
        sentences.each do |sent|
          next if sent.size <= k
          (0..sent.size - k - 1).each do |i|
            key = sent[i, k]
            (h[key] ||= []) << sent[i + k]
          end
        end
        h
      end
    end

    def sentence_df_index
      @sentence_df_cache ||= begin
        df = Hash.new(0)
        sentences.each do |sent|
          seen = {}
          sent.each do |t|
            c = Corpus.clean(t).downcase
            next if seen[c]
            seen[c] = true
            df[c] += 1
          end
        end
        df
      end
    end

    def invalidate_caches!
      @frequency_cache = nil
      @sentences_cache = nil
      @positions_cache = nil
      @terminator_cache = nil
      @ngram_cache = nil
      @sentence_df_cache = nil
    end
  end
end

# Components must load after Corpus / module constants exist — they reference
# SuperDaisy::SENTINEL and SuperDaisy::Corpus.clean.
require_relative "super_daisy/components/whitespace_tokenizer"
require_relative "super_daisy/components/rarest_word_scorer"
require_relative "super_daisy/components/bm25_scorer"
require_relative "super_daisy/components/uniform_sampler"
require_relative "super_daisy/components/stride_three_markov_generator"
require_relative "super_daisy/components/ppm_markov_generator"
require_relative "super_daisy/components/keyword_presence_filter"
require_relative "super_daisy/components/overlap_reranker"
require_relative "super_daisy/components/last_turn_memory"
require_relative "super_daisy/ugly"

module SuperDaisy
  module Components
    # Parse a string like "classic", "ppm", "ppm:4" into a generator instance.
    # Used by bin/eval and bin/daisy so the CLI surface stays consistent.
    def self.build_generator(spec)
      case spec
      when nil, "classic"
        StrideThreeMarkovGenerator.new
      when /\Appm(?::(\d+))?\z/
        order = $1 ? $1.to_i : PpmMarkovGenerator::DEFAULT_ORDER
        PpmMarkovGenerator.new(order: order)
      else
        raise ArgumentError, "unknown generator spec: #{spec.inspect}"
      end
    end

    # Parse a scorer spec into a scorer instance. Same shape as build_generator.
    def self.build_scorer(spec)
      case spec
      when nil, "classic", "rarest"
        RarestWordScorer.new
      when /\Abm25(?::(\d+))?\z/
        top_k = $1 ? $1.to_i : BM25Scorer::DEFAULT_TOP_K
        BM25Scorer.new(top_k: top_k)
      else
        raise ArgumentError, "unknown scorer spec: #{spec.inspect}"
      end
    end
  end
end

module SuperDaisy
  class Bot
    attr_accessor :max_candidates, :timeout, :pool_size, :max_length
    attr_reader :corpus, :last_stats
    attr_reader :tokenizer, :scorer, :generator, :filter, :reranker, :memory, :sampler

    def initialize(corpus,
                   tokenizer: Components::WhitespaceTokenizer.new,
                   scorer:    Components::RarestWordScorer.new,
                   generator: Components::StrideThreeMarkovGenerator.new,
                   filter:    Components::KeywordPresenceFilter.new,
                   reranker:  Components::OverlapReranker.new,
                   memory:    Components::LastTurnMemory.new,
                   sampler:   Components::UniformSampler.new,
                   max_candidates: 1000, timeout: 0.5, pool_size: 10,
                   max_length: 70, rng: Random.new)
      @corpus = corpus
      @tokenizer = tokenizer
      @scorer = scorer
      @generator = generator
      @filter = filter
      @reranker = reranker
      @memory = memory
      @sampler = sampler
      @max_candidates = max_candidates
      @timeout = timeout
      @pool_size = pool_size
      @max_length = max_length
      @rng = rng
      @last_stats = nil
    end

    def respond(input, learn: false)
      tokens = @tokenizer.call(input)
      @corpus.learn(tokens) if learn && !tokens.empty?
      best_response(tokens)
    end

    def best_response(input_tokens)
      if @corpus.empty?
        @last_stats = { attempts: 0, kept: 0, fallthrough: false, ugly: false }
        return ""
      end

      fresh = @scorer.call(input_tokens, @corpus)
      kws = (fresh + @memory.carry).uniq
      @memory.record(fresh)

      terminators = @corpus.terminator_bigrams
      kw_set = kws.each_with_object({}) { |k, h| h[Corpus.clean(k).downcase] = true }
      candidates = []
      attempts = 0
      deadline = @timeout ? monotime + @timeout : nil

      while candidates.size < @pool_size && attempts < @max_candidates
        attempts += 1
        sentence = generate(terminators)
        if !sentence.empty?
          overlap = @filter.call(sentence, kw_set)
          if kw_set.empty? || overlap > 0
            ugly = Ugly.judge(sentence, max_length: @max_length)
            candidates << [sentence, ugly, overlap]
          end
        end
        break if deadline && monotime >= deadline
      end

      # Fallback: no keyword-bearing candidate found within budget. Emit one
      # unfiltered Markov sentence — DAISY's classic "give up gracefully."
      if candidates.empty?
        sentence = generate(terminators)
        @last_stats = {
          attempts: attempts, kept: 0, fallthrough: true,
          ugly: Ugly.judge(sentence, max_length: @max_length),
        }
        return sentence
      end

      winner = @reranker.call(candidates)
      winner_entry = candidates.find { |s, _u, _o| s == winner }
      @last_stats = {
        attempts: attempts,
        kept: candidates.size,
        fallthrough: false,
        ugly: winner_entry ? winner_entry[1] : false,
      }
      winner
    end

    private

    def generate(terminators)
      @generator.call(corpus: @corpus, sampler: @sampler, rng: @rng,
                      terminators: terminators, max_length: @max_length)
    end

    def monotime
      Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end
  end
end
