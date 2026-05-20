# Truncated symmetric eigendecomposition via power iteration with deflation.
#
# Used to compute low-rank PPMI embeddings (the SVD of a symmetric PPMI
# matrix is its eigendecomposition).
#
# Pure Ruby, stdlib only. For sparse matrices with V vocabulary words and
# nnz non-zero entries, each matrix-vector product is O(nnz). Top-K
# eigenpairs cost ~O(K × iters × nnz). For V≈3-10K and K=50 that's a
# few seconds on the bigger corpora — a one-time cost at corpus load.
#
# Inputs to TruncatedEigh.call:
#   sparse_rows: Array<Array<[col_idx, value]>> — sparse symmetric matrix,
#                row i is the list of nonzero entries in row i.
#   k:           number of eigenpairs to return
#   iters:       power iteration steps per eigenvector (default 30)
#   rng:         seeded Random for reproducibility
#
# Returns [eigenvalues, eigenvectors] where eigenvectors is an Array of
# length-V Arrays. Sorted by descending |eigenvalue|.

module SuperDaisy
  module SVD
    EPS = 1.0e-12

    # Sparse matrix-vector multiply: y_i = sum_j M[i, j] * v[j]
    def self.matvec(sparse_rows, v)
      result = Array.new(sparse_rows.size, 0.0)
      sparse_rows.each_with_index do |row, i|
        s = 0.0
        row.each { |(j, val)| s += val * v[j] }
        result[i] = s
      end
      result
    end

    def self.norm(v)
      Math.sqrt(v.sum { |x| x * x })
    end

    def self.normalize!(v)
      n = norm(v)
      return v if n < EPS
      v.map! { |x| x / n }
      v
    end

    def self.dot(a, b)
      s = 0.0
      a.each_with_index { |x, i| s += x * b[i] }
      s
    end

    # Subtract the projection of v onto each previously-found eigenvector,
    # so power iteration converges to a new eigenpair rather than the same one.
    def self.orthogonalize!(v, prev_vecs)
      prev_vecs.each do |u|
        d = dot(v, u)
        v.each_index { |i| v[i] -= d * u[i] }
      end
      v
    end

    def self.call(sparse_rows, k:, iters: 30, rng: Random.new)
      n = sparse_rows.size
      eigenvalues = []
      eigenvectors = []
      return [eigenvalues, eigenvectors] if n.zero? || k.zero?

      k.times do
        v = Array.new(n) { rng.rand * 2 - 1 }
        normalize!(v)

        iters.times do
          orthogonalize!(v, eigenvectors)
          v = matvec(sparse_rows, v)
          break if normalize!(v).nil? || norm(v) < EPS
        end

        # Final orthogonalization + Rayleigh quotient for the eigenvalue.
        orthogonalize!(v, eigenvectors)
        normalize!(v)
        lambda = dot(v, matvec(sparse_rows, v))

        eigenvalues << lambda
        eigenvectors << v
      end

      [eigenvalues, eigenvectors]
    end
  end
end
