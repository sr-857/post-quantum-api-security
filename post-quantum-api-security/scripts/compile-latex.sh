#!/usr/bin/env bash
#
# compile-latex.sh
# Compiles paper/paper.tex to paper/paper.pdf using pdflatex + bibtex,
# running enough passes to resolve all citations and cross-references.
#
# Usage: ./scripts/compile-latex.sh [--engine xelatex|pdflatex]

set -euo pipefail

ENGINE="pdflatex"
if [[ "${1:-}" == "--engine" && -n "${2:-}" ]]; then
  ENGINE="$2"
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PAPER_DIR="${REPO_ROOT}/paper"

if ! command -v "${ENGINE}" >/dev/null 2>&1; then
  echo "Error: ${ENGINE} not found. Install a TeX distribution (e.g. texlive-latex-extra texlive-publishers)." >&2
  exit 1
fi

if ! command -v bibtex >/dev/null 2>&1; then
  echo "Error: bibtex not found. Install texlive-bibtex-extra." >&2
  exit 1
fi

echo "==> Compiling paper.tex with ${ENGINE} (pass 1/3)"
( cd "${PAPER_DIR}" && "${ENGINE}" -interaction=nonstopmode paper.tex > /dev/null )

echo "==> Running bibtex"
( cd "${PAPER_DIR}" && bibtex paper > /dev/null )

echo "==> Compiling paper.tex with ${ENGINE} (pass 2/3)"
( cd "${PAPER_DIR}" && "${ENGINE}" -interaction=nonstopmode paper.tex > /dev/null )

echo "==> Compiling paper.tex with ${ENGINE} (pass 3/3)"
( cd "${PAPER_DIR}" && "${ENGINE}" -interaction=nonstopmode paper.tex > /dev/null )

echo "==> Cleaning auxiliary files"
( cd "${PAPER_DIR}" && rm -f paper.aux paper.bbl paper.blg paper.log paper.out )

echo "==> Done. Output: ${PAPER_DIR}/paper.pdf"
