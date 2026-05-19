# Stage 6 — Conversation memory.
#
# Interface:
#   #carry           -> Array<String>   (keywords from previous turn)
#   #record(keywords)                   (overwrite with this turn's keywords)
#
# Default behavior: remembers only the last turn's keywords (matches DAISY's
# LastSubs carryover). Stateful — must be instance-per-bot.
#
# Future-fancy alternative: K-turn rolling window with exponential decay.

module SuperDaisy
  module Components
    class LastTurnMemory
      def initialize
        @last = []
      end

      def carry
        @last
      end

      def record(keywords)
        @last = keywords
      end
    end
  end
end
