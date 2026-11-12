#!/usr/bin/env bash
# Keeps lib/models plain Dart: no GetX, no Flutter, and nothing from the other folders, so what a piece of content
# is stays apart from how it is shown. Prints each offending import and fails if there is one.
set -euo pipefail
cd "$(dirname "$0")/.."
bad=0
grep -rnE "^import 'package:(get|flutter|material_ui)/" lib/models && bad=1
grep -rnE "^(import|export) '(\.\./|package:arandas_site/)(controllers|views|widgets|l10n|config)/" lib/models && bad=1
if [ "$bad" = 1 ]; then
  echo "lib/models must import neither GetX nor Flutter, nor anything outside lib/models." >&2
  exit 1
fi
echo "ok: lib/models is plain Dart and stands alone"
