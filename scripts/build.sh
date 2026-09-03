#!/usr/bin/env bash
# ==============================================================================
# SocrateAI-Lean-Lib: Full Build Script
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${ROOT_DIR}"

echo "══════════════════════════════════════════════════════════════════"
echo "           SocrateAI Lean 4 Full Build Pipeline                   "
echo "══════════════════════════════════════════════════════════════════"

if [[ "${1:-}" == "--clean" ]]; then
  echo "Cleaning Lake cache..."
  lake clean
fi

echo "Building all default library and test targets..."
lake build

echo ""
echo "══════════════════════════════════════════════════════════════════"
echo "🎉 Build completed successfully!"
echo "══════════════════════════════════════════════════════════════════"
