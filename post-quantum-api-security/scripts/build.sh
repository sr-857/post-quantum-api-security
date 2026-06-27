#!/usr/bin/env bash
#
# build.sh
# Master build script: validates the bibliography, then compiles the
# paper. Intended as the single entry point for CI and local builds.
#
# Usage: ./scripts/build.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== Post-Quantum API Security: Build ==="
echo

echo "--- Step 1/2: Validate bibliography ---"
"${REPO_ROOT}/scripts/generate-bib.sh"
echo

echo "--- Step 2/2: Compile paper ---"
"${REPO_ROOT}/scripts/compile-latex.sh"
echo

echo "=== Build complete ==="
echo "PDF: ${REPO_ROOT}/paper/paper.pdf"
