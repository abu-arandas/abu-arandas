#!/usr/bin/env bash
# Builds the site on Vercel, whose build machines have no Flutter: fetches the SDK (skipped when .flutter already
# holds this version), then builds into build/web, which vercel.json serves. The site needs no keys.
set -euo pipefail

FLUTTER_VERSION=3.47.7
FLUTTER_HOME="$PWD/.flutter"

if [ "$(cat "$FLUTTER_HOME/version" 2>/dev/null)" != "$FLUTTER_VERSION" ]; then
  rm -rf "$FLUTTER_HOME"
  git clone --quiet --depth 1 --branch "$FLUTTER_VERSION" https://github.com/flutter/flutter.git "$FLUTTER_HOME"
fi
export PATH="$FLUTTER_HOME/bin:$PATH"
flutter config --no-analytics --no-cli-animations > /dev/null
flutter --version

flutter pub get
flutter build web --release --wasm
