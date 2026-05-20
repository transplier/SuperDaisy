# On-disk cache for PPMI+SVD semantic embeddings.
#
# Computing embeddings on a 100K-token corpus is a few seconds; on a 1M-
# token corpus it's a few minutes. Caching means you only pay once per
# (corpus content, embedding params) combination.
#
# Layout:
#   <cache_dir>/<content_hash>-d<dims>-w<window>-mc<min_count>-s<seed>-v<format>.cache
#
# Cache dir defaults to $SUPER_DAISY_CACHE_DIR or
# $XDG_CACHE_HOME/super_daisy or ~/.cache/super_daisy.
#
# Binary format (little-endian):
#   magic    : 4 bytes "SDC\0"
#   version  : uint32  (FORMAT_VERSION)
#   dims     : uint32
#   window   : uint32
#   min_count: uint32
#   seed     : uint32
#   vocab_sz : uint32
#   hash     : 32 bytes (SHA-256 of corpus content)
#   vocab    : vocab_sz × (uint16 length + bytes)
#   floats   : vocab_sz × dims × float32 (packed 'g')

require "digest"
require "fileutils"

module SuperDaisy
  module SemanticCache
    MAGIC = "SDC\0".b.freeze
    FORMAT_VERSION = 1

    def self.cache_dir
      override = ENV["SUPER_DAISY_CACHE_DIR"]
      return override if override && !override.empty?
      base = ENV["XDG_CACHE_HOME"]
      base = File.join(Dir.home, ".cache") if base.nil? || base.empty?
      File.join(base, "super_daisy")
    end

    def self.path_for(content_hash, dims:, window:, min_count:, seed:)
      tag = content_hash.unpack1("H*")[0, 16]
      name = "#{tag}-d#{dims}-w#{window}-mc#{min_count}-s#{seed}-v#{FORMAT_VERSION}.cache"
      File.join(cache_dir, name)
    end

    # Streaming digest over the in-memory token list. Auto-invalidates on
    # learn() because the token sequence changes.
    def self.content_hash(tokens)
      d = Digest::SHA256.new
      tokens.each do |t|
        d.update(t)
        d.update("\0")
      end
      d.digest
    end

    def self.save(path, word_to_idx, embeddings, content_hash, dims:, window:, min_count:, seed:)
      FileUtils.mkdir_p(File.dirname(path))
      vocab = Array.new(word_to_idx.size)
      word_to_idx.each { |w, i| vocab[i] = w }
      File.open(path, "wb") do |f|
        f.write(MAGIC)
        f.write([FORMAT_VERSION, dims, window, min_count, seed, vocab.size].pack("L<6"))
        f.write(content_hash)
        vocab.each do |w|
          bytes = w.b
          f.write([bytes.bytesize].pack("S<"))
          f.write(bytes)
        end
        flat = embeddings.flatten
        f.write(flat.pack("g*"))
      end
    end

    # Returns [word_to_idx, embeddings] on cache hit, nil on any failure.
    def self.load(path, expected_hash, dims:, window:, min_count:, seed:)
      return nil unless File.exist?(path)
      File.open(path, "rb") do |f|
        return nil unless f.read(4) == MAGIC
        version, d, win, mc, sd, vs = f.read(24).unpack("L<6")
        return nil unless version == FORMAT_VERSION
        return nil unless d == dims && win == window && mc == min_count && sd == seed
        return nil unless f.read(32) == expected_hash
        vocab = Array.new(vs)
        vs.times do |i|
          len = f.read(2).unpack1("S<")
          vocab[i] = f.read(len).force_encoding("UTF-8")
        end
        n_floats = vs * dims
        flat = f.read(n_floats * 4).unpack("g#{n_floats}")
        embeddings = flat.each_slice(dims).map(&:to_a)
        word_to_idx = {}
        vocab.each_with_index { |w, i| word_to_idx[w] = i }
        return [word_to_idx, embeddings]
      end
    rescue StandardError
      nil
    end
  end
end
