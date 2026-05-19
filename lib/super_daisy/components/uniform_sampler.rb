# Stage 7 — Sampler.
#
# Interface: #call(items, rng) -> item
#
# Default behavior: uniform random over items (matches DAISY's coin-flip
# branch selection). All RNG draws inside the Markov walk flow through this
# component, so swapping it is enough to introduce temperature / top-p / etc.
#
# Future-fancy alternatives:
#   - TemperatureSampler: weight items by some external score raised to 1/T.
#   - TopPSampler: sort by weight, sample from smallest set that sums >= p.

module SuperDaisy
  module Components
    class UniformSampler
      def call(items, rng)
        items[rng.rand(items.size)]
      end
    end
  end
end
