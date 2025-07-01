#!/bin/bash

# Exit on any error
set -e  # Exit on any error
# 2025-06-28T18:11Z AI: fail early if required commands are missing (pnpm, cargo)
command -v pnpm >/dev/null 2>&1 || { echo "pnpm not found; please install it." >&2; exit 1; }
command -v cargo >/dev/null 2>&1 || { echo "cargo not found; please install Rust." >&2; exit 1; }
set -o pipefail

# 2025-06-28T18:11Z AI: centralize script root path for consistency
ROOT="$(cd "$(dirname "$0")" && pwd)"
echo "🔧 Installing dependencies for codex-cli..."
cd "$ROOT/codex-cli"
pnpm install
echo "✅ codex-cli dependencies installed"

echo "🛠️  Building codex-cli..."
pnpm run build
echo "✅ codex-cli built"

echo "🔧 Installing dependencies for codex-rs..."
cd "$ROOT/codex-rs"
# 2025-06-28T18:11Z AI: only install pnpm deps if package.json is present
if [ -f package.json ]; then
  pnpm install
fi
echo "✅ codex-rs dependencies handled"

echo "🛠️  Building codex-rs..."
if [ -f Cargo.toml ]; then
  BUILT_REV_FILE=".codex_last_built_rev"
  current_rev=$(git rev-parse HEAD)
  if [ -f "$BUILT_REV_FILE" ] && [ "$(cat "$BUILT_REV_FILE")" = "$current_rev" ]; then
    echo "🔄 Skipping codex-rs build; no changes detected since last build (rev $current_rev)"
  else
    cargo build --release
    echo "$current_rev" > "$BUILT_REV_FILE"
  fi
else
  pnpm run build
fi
echo "✅ codex-rs built"

echo "🎉 All components built locally with no global installs."
