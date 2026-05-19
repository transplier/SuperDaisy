# Stage 1 — Tokenizer.
#
# Interface: #call(text) -> Array<String>
#
# Default behavior: lowercase, whitespace-split, append "." if the input lacks
# terminal punctuation. Mirrors the original DAISY parser's normalization.
#
# Future-fancy alternative: BPE / WordPiece tokenizer (would unify
# "platypus" and "platypus." into shared subword units).

module SuperDaisy
  module Components
    class WhitespaceTokenizer
      def call(text)
        text = text.to_s.downcase.strip
        return [] if text.empty?
        text += "." unless text =~ TERMINAL_PUNCT
        text.split(/\s+/)
      end
    end
  end
end
