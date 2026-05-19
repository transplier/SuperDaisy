# Baseline timings for Daisy::Bot. Reports per-method breakdown and end-to-end
# latency for a fixed seed and prompt set against each .DSY corpus given on
# the command line (or a sensible default set).
#
#   ruby -Ilib benchmark/respond.rb
#   ruby -Ilib benchmark/respond.rb path/to/foo.DSY path/to/bar.DSY
#
# Stdlib only.

require "benchmark"
require_relative "../lib/daisy"

CORPORA = if ARGV.empty?
  [
    "daisy11 original freepascal/MEM.DSY",
    "fortune-haiku-3-5-250.DSY",
  ].select { |p| File.exist?(p) }
else
  ARGV
end

PROMPTS = [
  "hello daisy how are you",
  "what is your favorite animal",
  "tell me something interesting",
  "the quick brown fox jumps",
  "i love to learn new things",
].freeze

SEED = 42
TRIALS = 5  # repeated full passes through PROMPTS

def stats(times)
  sorted = times.sort
  n = sorted.size
  mean = times.sum / n
  median = n.odd? ? sorted[n / 2] : (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0
  { mean: mean, median: median, min: sorted.first, max: sorted.last }
end

def fmt_ms(seconds)
  format("%7.2f ms", seconds * 1000)
end

def summarize(label, times)
  s = stats(times)
  printf "  %-22s n=%d  mean=%s  median=%s  min=%s  max=%s\n",
         label, times.size, fmt_ms(s[:mean]), fmt_ms(s[:median]),
         fmt_ms(s[:min]), fmt_ms(s[:max])
end

CORPORA.each do |path|
  unless File.exist?(path)
    warn "skip (missing): #{path}"
    next
  end

  corpus = Daisy::Corpus.load(path)
  total_tokens = corpus.tokens.size
  word_tokens = corpus.total_word_tokens
  sentences = corpus.sentences.size

  puts "=" * 72
  puts "Corpus: #{path}"
  puts "  tokens=#{total_tokens}  words=#{word_tokens}  sentences=#{sentences}"
  puts "  seed=#{SEED}  trials=#{TRIALS}  prompts=#{PROMPTS.size}  time_budget=3.0s"
  puts

  # Pre-warm (load file caches, JIT-ish, allocate constant pools).
  warm_bot = Daisy::Bot.new(corpus, rng: Random.new(SEED))
  warm_bot.respond(PROMPTS.first, learn: false)

  respond_times = []
  generate_times = []
  keywords_times = []
  terminator_times = []

  TRIALS.times do
    bot = Daisy::Bot.new(corpus, rng: Random.new(SEED))
    PROMPTS.each do |prompt|
      t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      bot.respond(prompt, learn: false)
      respond_times << (Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0)
    end
  end

  # Component microbenchmarks (fresh bot, isolated calls).
  micro_bot = Daisy::Bot.new(corpus, rng: Random.new(SEED))
  tokens = micro_bot.tokenize(PROMPTS.first)

  50.times do
    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    micro_bot.terminator_bigrams
    terminator_times << (Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0)
  end

  50.times do
    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    micro_bot.keywords(tokens)
    keywords_times << (Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0)
  end

  term = micro_bot.terminator_bigrams
  50.times do
    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    micro_bot.generate_sentence(term)
    generate_times << (Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0)
  end

  puts "End-to-end respond()"
  summarize("per-prompt", respond_times)
  puts
  puts "Component breakdown"
  summarize("generate_sentence", generate_times)
  summarize("keywords", keywords_times)
  summarize("terminator_bigrams", terminator_times)
  puts
end
