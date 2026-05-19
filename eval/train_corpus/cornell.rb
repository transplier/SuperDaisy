#!/usr/bin/env ruby
# Build a .DSY from the Cornell Movie Dialog Corpus.
#
# Reads utterances.jsonl (one utterance per line, ConvoKit format), filters
# to sentences in a reasonable length band, optionally subsamples, and
# writes a DAISY-format token file.
#
# Usage:
#   eval/train_corpus/cornell.rb --out movie.DSY --sentences 5000
#   eval/train_corpus/cornell.rb --out movie-big.DSY --tokens 100000

require "optparse"
require "json"
require_relative "../../lib/daisy"

DEFAULTS = {
  input: "eval/corpus/movie-corpus/utterances.jsonl",
  out: "movie.DSY",
  sentences: nil,
  tokens: nil,
  min_words: 4,
  max_words: 25,
  bot_name: "Daisy",
  seed: 1,
  preserve_convos: false,
}

opts = DEFAULTS.dup
OptionParser.new do |o|
  o.banner = "Usage: cornell.rb [options]"
  o.on("--input FILE", "utterances.jsonl path (default #{DEFAULTS[:input]})") { |v| opts[:input] = v }
  o.on("--out FILE", "Output .DSY (default #{DEFAULTS[:out]})") { |v| opts[:out] = v }
  o.on("--sentences N", Integer, "Subsample to N sentences (mutually exclusive with --tokens)") { |v| opts[:sentences] = v }
  o.on("--tokens N", Integer, "Subsample until ~N word tokens accumulated") { |v| opts[:tokens] = v }
  o.on("--min-words N", Integer, "Drop sentences with fewer words (default #{DEFAULTS[:min_words]})") { |v| opts[:min_words] = v }
  o.on("--max-words N", Integer, "Drop sentences with more words (default #{DEFAULTS[:max_words]})") { |v| opts[:max_words] = v }
  o.on("--bot-name NAME", "Bot name in DSY header (default #{DEFAULTS[:bot_name]})") { |v| opts[:bot_name] = v }
  o.on("--seed N", Integer, "RNG seed for subsampling (default #{DEFAULTS[:seed]})") { |v| opts[:seed] = v }
  o.on("--preserve-convos", "Keep utterances in conversation order rather than shuffling") { opts[:preserve_convos] = true }
  o.on("-h", "--help") { puts o; exit 0 }
end.parse!

if opts[:sentences] && opts[:tokens]
  warn "--sentences and --tokens are mutually exclusive"
  exit 1
end

unless File.exist?(opts[:input])
  warn "input not found: #{opts[:input]}"
  exit 1
end

# Drop lines that are mostly non-text — stage directions, all-caps shouts,
# things that won't tokenize cleanly. Cornell text is generally clean but
# has occasional "--" speaker continuations and bracket annotations.
JUNK_RE = /\A\s*[\[(]|--\s*\z|\A[A-Z\s\W]{8,}\z/

# Reject things with obvious transcription noise.
BAD_CHARS_RE = /[<>{}\[\]\|\\]|\.\.\.\.|--/

def good_sentence?(text, min_words, max_words)
  return false if text.nil? || text.empty?
  return false if text =~ BAD_CHARS_RE
  return false if text =~ JUNK_RE
  # Reject if more than ~30% of chars are non-word/space/punct.
  word_chars = text.count("A-Za-z0-9 ")
  return false if word_chars.to_f / text.length < 0.7
  wc = text.split.size
  wc >= min_words && wc <= max_words
end

rng = Random.new(opts[:seed])
candidates = []

$stderr.puts "reading #{opts[:input]}..."
File.foreach(opts[:input]) do |line|
  rec = begin
    JSON.parse(line)
  rescue JSON::ParserError
    next
  end
  text = rec["text"].to_s.strip
  next unless good_sentence?(text, opts[:min_words], opts[:max_words])
  candidates << text
end

$stderr.puts "kept #{candidates.size} candidate sentences after filtering"

if candidates.empty?
  warn "no sentences passed filters"
  exit 1
end

# Order: shuffle unless caller wants conversation flow preserved. Either way
# we subsample by truncation after this point.
candidates.shuffle!(random: rng) unless opts[:preserve_convos]

corpus = Daisy::Corpus.new(bot_name: opts[:bot_name], learn_mode: true)
bot = Daisy::Bot.new(corpus)

target_sentences = opts[:sentences]
target_tokens = opts[:tokens]

kept = 0
candidates.each do |text|
  break if target_sentences && kept >= target_sentences
  break if target_tokens && corpus.total_word_tokens >= target_tokens
  tokens = bot.tokenize(text)
  next if tokens.empty?
  corpus.learn(tokens)
  kept += 1
end

corpus.save(opts[:out])
puts "wrote #{opts[:out]} (#{corpus.total_word_tokens} tokens, #{kept} sentences)"
