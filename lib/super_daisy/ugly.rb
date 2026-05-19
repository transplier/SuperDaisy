# Post-hoc judgment of whether a generated response looks "ugly".
#
# Operates on the output string + max_length, not on the walk that produced
# it. Generator-independent: classic stride-3, PPM, and any future
# generator are all evaluated by the same rule, so the eval metric is
# apples-to-apples.
#
# The cycle heuristic is the stride-independent generalization of the
# Pascal original's check. Classic DAISY tested `chunk[k] == words[k-2]`
# for k in 0..2 after each 3-token emission, which is "ABA pattern at the
# last three emit positions." Applied to every position in the sentence
# yields a sliding ABA check.

module SuperDaisy
  module Ugly
    # Any A?A pattern anywhere in `words`: words[i] == words[i-2].
    def self.cyclic?(words)
      (2...words.size).each do |i|
        return true if words[i] == words[i - 2]
      end
      false
    end

    def self.over_length?(sentence, max_length)
      sentence.length > max_length
    end

    # Headline judgment used by the Bot orchestrator.
    def self.judge(sentence, max_length:)
      return false if sentence.empty?
      return true if over_length?(sentence, max_length)
      cyclic?(sentence.split(/\s+/))
    end
  end
end
