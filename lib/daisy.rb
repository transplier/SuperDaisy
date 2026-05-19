# Ruby port of DAISY v1.1 (Greg Leedberg, 2000-2005).
#
# A 1st-order Markov sentence sampler over a flat token-list corpus, with
# rarest-word keyword extraction and a generate/filter/rerank response loop.
# See DAISY.md for the algorithmic write-up.

module Daisy
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
      @frequency_cache = nil
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
      @frequency_cache = nil
    end

    # Case-insensitive, punctuation-stripped occurrence count.
    # Backs the original "Percent" IDF surrogate. O(1) after a one-time
    # corpus-wide scan; cache is invalidated on learn().
    def token_frequency(word)
      frequency_table[Corpus.clean(word).downcase] || 0
    end

    # Hash<cleaned_lowercase_word, count> over all non-sentinel tokens.
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

    # Yields each sentence as an Array<String> of tokens (no sentinel).
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
      result = []
      each_sentence { |s| result << s }
      result
    end

    def self.clean(s)
      s.gsub(PUNCTUATION, "")
    end
  end

  class Bot
    attr_accessor :max_candidates, :pool_size, :max_length
    attr_reader :corpus, :last_keywords

    def initialize(corpus, max_candidates: 1000, pool_size: 10, max_length: 70,
                   rng: Random.new)
      @corpus = corpus
      @max_candidates = max_candidates
      @pool_size = pool_size
      @max_length = max_length
      @rng = rng
      @last_keywords = []
    end

    # Lowercase, whitespace-split. Ensures the final token carries terminal
    # punctuation (matches the pre-parse normalization in the original).
    def tokenize(text)
      text = text.to_s.downcase.strip
      return [] if text.empty?
      text += "." unless text =~ TERMINAL_PUNCT
      text.split(/\s+/)
    end

    # Set of two-token tails of every memorized sentence. Computed once per
    # response call; replaces the on-disk term.bfb the original wrote each turn.
    def terminator_bigrams
      set = {}
      @corpus.each_sentence do |s|
        next if s.size < 2
        set[[s[-2], s[-1]]] = true
      end
      set
    end

    # 1st-order Markov walk with stride-3 emission. Returns [sentence, ugly].
    def generate_sentence(terminators = terminator_bigrams)
      sents = @corpus.sentences
      return ["", false] if sents.empty?

      seed = sents[@rng.rand(sents.size)]
      words = seed.first(3).dup
      ugly = false

      loop do
        last = words.last
        positions = []
        @corpus.tokens.each_with_index do |t, i|
          positions << i if t == last
        end
        break if positions.empty?

        idx = positions[@rng.rand(positions.size)]
        chunk = []
        (1..3).each do |k|
          nxt = @corpus.tokens[idx + k]
          break if nxt.nil? || nxt == SENTINEL
          chunk << nxt
        end
        break if chunk.empty?

        # Local-cycle detection (matches the original's #14 sentinel triggers).
        if words.size >= 3 && chunk.size >= 1
          ugly ||= chunk[0] == words[-2]
          ugly ||= chunk.size >= 2 && chunk[1] == words[-1]
          ugly ||= chunk.size >= 3 && chunk[2] == chunk[0]
        end

        words.concat(chunk)

        # Terminate when the trailing bigram matches a learned sentence ending.
        if words.size >= 2 && terminators[[words[-2], words[-1]]]
          break
        end

        if words.join(" ").length > @max_length
          ugly = true
          break
        end
      end

      [words.join(" "), ugly]
    end

    # Rarest-word keyword extraction. All input tokens tied at the minimum
    # corpus frequency are returned (matches BestResponse, daisy.pas:1655).
    def keywords(input_tokens)
      return [] if input_tokens.empty?
      freqs = input_tokens.map { |t| [t, @corpus.token_frequency(t)] }
      min_freq = freqs.map(&:last).min
      freqs.select { |_, f| f == min_freq }.map(&:first)
    end

    # Top-level: optionally learn, then pick the best candidate response.
    def respond(input, learn: false)
      tokens = tokenize(input)
      @corpus.learn(tokens) if learn && !tokens.empty?
      best_response(tokens)
    end

    def best_response(input_tokens)
      return "" if @corpus.empty?

      kws = keywords(input_tokens) + @last_keywords
      kws.uniq!
      @last_keywords = keywords(input_tokens)

      terminators = terminator_bigrams
      candidates = []
      attempts = 0

      while candidates.size < @pool_size && attempts < @max_candidates
        attempts += 1
        sentence, ugly = generate_sentence(terminators)
        next if sentence.empty?
        overlap = keyword_overlap(sentence, kws)
        next if !kws.empty? && overlap.zero?
        candidates << [sentence, ugly, overlap]
      end

      # Fallback: no keyword-bearing candidate found within attempt cap.
      if candidates.empty?
        sentence, _ugly = generate_sentence(terminators)
        return sentence
      end

      # Highest overlap wins; on ties, prefer non-ugly.
      candidates.max_by.with_index { |(_s, ugly, ov), i| [ov, ugly ? 0 : 1, i] }[0]
    end

    private

    def keyword_overlap(sentence, kws)
      return 0 if kws.empty?
      sentence_tokens = sentence.split(/\s+/).map { |t| Corpus.clean(t).downcase }
      kw_clean = kws.map { |k| Corpus.clean(k).downcase }
      sentence_tokens.count { |t| kw_clean.include?(t) }
    end
  end
end
