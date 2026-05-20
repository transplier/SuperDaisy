#!/usr/bin/env bash
# Regenerate every eval report, data dump, and chart in eval/.
# Run from repo root: ./eval/run_all.sh
#
# Idempotent. Runs eval jobs in parallel.
#
# Matrix:
#   baseline  — classic generator + rarest-word scorer (default everything)
#   +ppm      — PPM:4 generator only
#   +bm25     — BM25 scorer only
#   full      — PPM:4 + BM25 (every accepted upgrade enabled)
#
# This deliberately skips the full combinatorial cross-product (any-K PPM ×
# any scorer × any future swap); the four configs above give us each upgrade
# in isolation plus the stacked end state, which is enough signal for the
# accept/reject calls described in SUPER_DAISY.md.

set -euo pipefail

cd "$(dirname "$0")/.."

MEM='daisy11 original freepascal/MEM.DSY'
FORTUNE='fortune-haiku-3-5-250.DSY'
MOVIE5K='pretrained/movie-5k.DSY'
MOVIE100K='pretrained/movie-100k.DSY'

# Corpora as label:path pairs. Add a new corpus here and it joins the matrix.
CORPORA=(
  "mem:$MEM"
  "fortune:$FORTUNE"
  "movie5k:$MOVIE5K"
  "movie100k:$MOVIE100K"
)

echo "[run_all] tests"
ruby -Ilib test/daisy_test.rb >/dev/null
ruby -Ilib test/super_daisy_test.rb >/dev/null

echo "[run_all] baselines (parallel)"
for spec in "${CORPORA[@]}"; do
  tag="${spec%%:*}"; path="${spec#*:}"
  bin/eval --personality "$path" --label "baseline-$tag" \
           --report "eval/baseline_${tag}.md" --data "eval/baseline_${tag}.json" &
done
wait

echo "[run_all] variants × all corpora (parallel)"
for spec in "${CORPORA[@]}"; do
  tag="${spec%%:*}"; path="${spec#*:}"
  base="--baseline eval/baseline_${tag}.json"

  # core matrix
  bin/eval --personality "$path" --label "ppm-$tag" --generator ppm:4 $base \
           --report "eval/ppm_${tag}.md" --data "eval/ppm_${tag}.json" &
  bin/eval --personality "$path" --label "bm25-$tag" --scorer bm25 $base \
           --report "eval/bm25_${tag}.md" --data "eval/bm25_${tag}.json" &
  bin/eval --personality "$path" --label "full-$tag" --generator ppm:4 --scorer bm25 $base \
           --report "eval/full_${tag}.md" --data "eval/full_${tag}.json" &

  # coherence probes: BM25 with low and mid temperature
  bin/eval --personality "$path" --label "bm25t05-$tag" --scorer bm25 --sampler temperature:0.5 $base \
           --report "eval/bm25t05_${tag}.md" --data "eval/bm25t05_${tag}.json" &
  bin/eval --personality "$path" --label "bm25t07-$tag" --scorer bm25 --sampler temperature:0.7 $base \
           --report "eval/bm25t07_${tag}.md" --data "eval/bm25t07_${tag}.json" &

  # PPM at order 2: lower-context PPM as a less-recitation-prone alternative
  bin/eval --personality "$path" --label "ppm2-$tag" --generator ppm:2 $base \
           --report "eval/ppm2_${tag}.md" --data "eval/ppm2_${tag}.json" &

  # Prompt-aware seed selection — bias initial sentence pick toward
  # keyword-bearing corpus sentences. Tested with BM25 alone and with PPM:2.
  bin/eval --personality "$path" --label "bm25seed-$tag" --scorer bm25 --seed-selector keyword $base \
           --report "eval/bm25seed_${tag}.md" --data "eval/bm25seed_${tag}.json" &
  bin/eval --personality "$path" --label "bm25seed-ppm2-$tag" --scorer bm25 --seed-selector keyword --generator ppm:2 $base \
           --report "eval/bm25seed_ppm2_${tag}.md" --data "eval/bm25seed_ppm2_${tag}.json" &

  # Density reranker on top of the seeded BM25 stack.
  bin/eval --personality "$path" --label "bm25seed-density-$tag" --scorer bm25 --seed-selector keyword --reranker density $base \
           --report "eval/bm25seed_density_${tag}.md" --data "eval/bm25seed_density_${tag}.json" &
  bin/eval --personality "$path" --label "bm25seed-ppm2-density-$tag" --scorer bm25 --seed-selector keyword --generator ppm:2 --reranker density $base \
           --report "eval/bm25seed_ppm2_density_${tag}.md" --data "eval/bm25seed_ppm2_density_${tag}.json" &
done
wait

if command -v gnuplot >/dev/null 2>&1; then
  echo "[run_all] charts"
  gnuplot eval/baseline.gp
  gnuplot eval/comparison.gp
else
  echo "[run_all] gnuplot not found, skipping charts"
fi

echo "[run_all] done"
