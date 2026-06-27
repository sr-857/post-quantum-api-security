#!/usr/bin/env bash
#
# generate-bib.sh
# Validates references.bib for common issues (duplicate keys, missing
# required fields) before a paper build. This is a lightweight sanity
# check, not a full BibTeX linter.
#
# Usage: ./scripts/generate-bib.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIB_FILE="${REPO_ROOT}/paper/references.bib"

if [[ ! -f "${BIB_FILE}" ]]; then
  echo "Error: ${BIB_FILE} not found." >&2
  exit 1
fi

echo "==> Checking for duplicate citation keys"
DUPES=$(grep -oP '^@\w+\{\K[^,]+' "${BIB_FILE}" | sort | uniq -d || true)
if [[ -n "${DUPES}" ]]; then
  echo "Error: duplicate citation keys found:" >&2
  echo "${DUPES}" >&2
  exit 1
fi
echo "    No duplicate keys found."

echo "==> Checking for entries missing a title field"
MISSING_TITLE=0
while IFS= read -r entry; do
  if [[ -z "${entry}" ]]; then
    continue
  fi
  if ! echo "${entry}" | grep -q "title"; then
    echo "Warning: entry may be missing a title: ${entry:0:60}..."
    MISSING_TITLE=1
  fi
done < <(grep -v '^\s*%' "${BIB_FILE}" | awk '/^@/{if (entry) print entry; entry=""} {entry = entry $0}')

if [[ "${MISSING_TITLE}" -eq 0 ]]; then
  echo "    All entries appear to have a title field."
fi

echo "==> Citation key count:"
grep -c '^@' "${BIB_FILE}"

echo "==> Done."
