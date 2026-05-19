#!/usr/bin/env bash
# Launch DAISY interactively against a temp copy of the shipped MEM.DSY
# so the original corpus stays pristine.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
SRC="$HERE/daisy11 original freepascal/MEM.DSY"

if [ ! -f "$SRC" ]; then
  echo "missing source corpus: $SRC" >&2
  exit 1
fi

TMP="$(mktemp -t daisy-demo.XXXXXX.dsy)"
trap 'rm -f "$TMP"' EXIT

cp "$SRC" "$TMP"
echo "Using temporary personality: $TMP"
echo "(Original MEM.DSY is untouched. Type 'exit' or Ctrl-D to quit.)"
echo

exec "$HERE/bin/daisy" --personality "$TMP" --learn
