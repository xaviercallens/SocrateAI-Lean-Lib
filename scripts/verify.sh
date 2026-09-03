#!/usr/bin/env bash
# ==============================================================================
# SocrateAI-Lean-Lib: Proof Verification Script
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${ROOT_DIR}"

echo "══════════════════════════════════════════════════════════════════"
echo "           SocrateAI Lean 4 Proof Verification Suite              "
echo "══════════════════════════════════════════════════════════════════"

echo "Checking Lean 4 toolchain..."
lean --version
lake --version

echo ""
echo "Verifying Core, Duality, K3, Ramanujan, Navier-Stokes, String Theory, AlienMath..."
lake build SocrateAI

echo ""
echo "Running Unit Verification Test Suites..."
lake build Tests

echo ""
echo "══════════════════════════════════════════════════════════════════"
echo "✅ All proofs and unit tests verified successfully!"
echo "══════════════════════════════════════════════════════════════════"
