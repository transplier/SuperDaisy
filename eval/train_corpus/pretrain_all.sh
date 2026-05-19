#!/usr/bin/env bash
# Regenerate every .DSY in pretrained/ from the Cornell corpus, in parallel.
#
# Sizes match the files currently shipped in pretrained/. Edit the table
# below if you want to add or change a build.

set -euo pipefail

cd "$(dirname "$0")/../.."

OUTDIR="pretrained"
mkdir -p "$OUTDIR"

# name              tokens-flag        value
BUILDS=(
  "movie-5k.DSY     --sentences       5000"
  "movie-100k.DSY   --tokens          100000"
  "movie-1m.DSY     --tokens          1000000"
)

pids=()
logs=()
for spec in "${BUILDS[@]}"; do
  # shellcheck disable=SC2086
  read -r name flag value <<<"$spec"
  log=$(mktemp -t "pretrain-${name%.DSY}.XXXXXX.log")
  logs+=("$log")
  echo "[start] $name ($flag $value) -> $OUTDIR/$name"
  (
    eval/train_corpus/cornell.rb "$flag" "$value" --out "$OUTDIR/$name" \
      >"$log" 2>&1
  ) &
  pids+=("$!")
done

fail=0
for i in "${!pids[@]}"; do
  pid="${pids[$i]}"
  log="${logs[$i]}"
  if wait "$pid"; then
    echo "[done]  build $i"
    tail -n 1 "$log"
  else
    echo "[FAIL]  build $i — log:"
    cat "$log"
    fail=1
  fi
  rm -f "$log"
done

exit "$fail"
