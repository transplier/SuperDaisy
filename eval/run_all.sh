#!/usr/bin/env bash
# Regenerate every eval report, data dump, and chart in eval/.
# Run from repo root: ./eval/run_all.sh
#
# Idempotent. Takes ~1 minute on a modern laptop.

set -euo pipefail

cd "$(dirname "$0")/.."

MEM='daisy11 original freepascal/MEM.DSY'
FORTUNE='fortune-haiku-3-5-250.DSY'

echo "[run_all] tests"
ruby -Ilib test/daisy_test.rb >/dev/null
ruby -Ilib test/super_daisy_test.rb >/dev/null

echo "[run_all] baseline — MEM.DSY"
bin/eval --personality "$MEM" \
         --label mem.dsy \
         --report eval/baseline_mem.md --data eval/baseline_mem.json

echo "[run_all] baseline — fortune-haiku"
bin/eval --personality "$FORTUNE" \
         --label fortune-haiku-3-5-250 \
         --report eval/baseline_fortune.md --data eval/baseline_fortune.json

for order in 3 4 5; do
  echo "[run_all] PPM order=$order — MEM.DSY"
  bin/eval --personality "$MEM" \
           --label "ppm-$order-mem" --generator "ppm:$order" \
           --baseline eval/baseline_mem.json \
           --report "eval/ppm${order}_mem.md" --data "eval/ppm${order}_mem.json"

  echo "[run_all] PPM order=$order — fortune-haiku"
  bin/eval --personality "$FORTUNE" \
           --label "ppm-$order-fortune" --generator "ppm:$order" \
           --baseline eval/baseline_fortune.json \
           --report "eval/ppm${order}_fortune.md" --data "eval/ppm${order}_fortune.json"
done

if command -v gnuplot >/dev/null 2>&1; then
  echo "[run_all] charts"
  gnuplot eval/baseline.gp
  gnuplot eval/ppm.gp
else
  echo "[run_all] gnuplot not found, skipping charts"
fi

echo "[run_all] done"
