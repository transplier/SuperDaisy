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

echo "[run_all] tests"
ruby -Ilib test/daisy_test.rb >/dev/null
ruby -Ilib test/super_daisy_test.rb >/dev/null

echo "[run_all] baselines (parallel)"
bin/eval --personality "$MEM" \
         --label mem.dsy \
         --report eval/baseline_mem.md --data eval/baseline_mem.json &
bin/eval --personality "$FORTUNE" \
         --label fortune-haiku-3-5-250 \
         --report eval/baseline_fortune.md --data eval/baseline_fortune.json &
wait

echo "[run_all] +ppm, +bm25, full × {mem,fortune} (parallel)"

# +ppm
bin/eval --personality "$MEM" --label ppm-mem --generator ppm:4 \
         --baseline eval/baseline_mem.json \
         --report eval/ppm_mem.md --data eval/ppm_mem.json &
bin/eval --personality "$FORTUNE" --label ppm-fortune --generator ppm:4 \
         --baseline eval/baseline_fortune.json \
         --report eval/ppm_fortune.md --data eval/ppm_fortune.json &

# +bm25
bin/eval --personality "$MEM" --label bm25-mem --scorer bm25 \
         --baseline eval/baseline_mem.json \
         --report eval/bm25_mem.md --data eval/bm25_mem.json &
bin/eval --personality "$FORTUNE" --label bm25-fortune --scorer bm25 \
         --baseline eval/baseline_fortune.json \
         --report eval/bm25_fortune.md --data eval/bm25_fortune.json &

# full
bin/eval --personality "$MEM" --label full-mem --generator ppm:4 --scorer bm25 \
         --baseline eval/baseline_mem.json \
         --report eval/full_mem.md --data eval/full_mem.json &
bin/eval --personality "$FORTUNE" --label full-fortune --generator ppm:4 --scorer bm25 \
         --baseline eval/baseline_fortune.json \
         --report eval/full_fortune.md --data eval/full_fortune.json &

wait

if command -v gnuplot >/dev/null 2>&1; then
  echo "[run_all] charts"
  gnuplot eval/baseline.gp
  gnuplot eval/comparison.gp
else
  echo "[run_all] gnuplot not found, skipping charts"
fi

echo "[run_all] done"
