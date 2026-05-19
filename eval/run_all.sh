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

echo "[run_all] +ppm, +bm25, full × all corpora (parallel)"
for spec in "${CORPORA[@]}"; do
  tag="${spec%%:*}"; path="${spec#*:}"

  bin/eval --personality "$path" --label "ppm-$tag" --generator ppm:4 \
           --baseline "eval/baseline_${tag}.json" \
           --report "eval/ppm_${tag}.md" --data "eval/ppm_${tag}.json" &

  bin/eval --personality "$path" --label "bm25-$tag" --scorer bm25 \
           --baseline "eval/baseline_${tag}.json" \
           --report "eval/bm25_${tag}.md" --data "eval/bm25_${tag}.json" &

  bin/eval --personality "$path" --label "full-$tag" --generator ppm:4 --scorer bm25 \
           --baseline "eval/baseline_${tag}.json" \
           --report "eval/full_${tag}.md" --data "eval/full_${tag}.json" &
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
