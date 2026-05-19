# Stage 7 alternative — temperature-weighted sampler.
#
# Interface: #call(items, rng) -> item
#
# items is a multiset (the multiplicity is the underlying frequency
# signal). The uniform sampler picks at rate proportional to count.
# Temperature reshapes that:
#
#   weight(item) = count(item) ** (1 / T)
#
#   T = 1.0   → uniform over multiset (== UniformSampler)
#   T < 1.0   → peakier, favors the most common continuation
#               (more locally coherent, less diverse)
#   T > 1.0   → flatter, favors rarer continuations
#               (more chaotic)
#
# Same data, same walker — this is purely a re-weighting of the existing
# candidate distribution. Kernel preserved: outputs still come verbatim
# from the corpus, never invented.

module SuperDaisy
  module Components
    class TemperatureSampler
      attr_reader :temperature

      def initialize(temperature: 1.0)
        raise ArgumentError, "temperature must be > 0" if temperature <= 0
        @temperature = temperature
      end

      def call(items, rng)
        return nil if items.empty?
        return items.first if items.size == 1

        counts = Hash.new(0)
        items.each { |item| counts[item] += 1 }

        inv_t = 1.0 / @temperature
        weighted = counts.map { |item, c| [item, c.to_f ** inv_t] }
        total = weighted.sum { |_, w| w }

        r = rng.rand * total
        cum = 0.0
        weighted.each do |item, w|
          cum += w
          return item if r < cum
        end
        weighted.last[0]
      end
    end
  end
end
