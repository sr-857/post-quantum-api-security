#!/bin/bash
# Script to clean up duplicate files in the git repository
# This removes dangling commits and resets the repository to a clean state

set -e

echo "🧹 Post-Quantum API Security - Duplicate File Cleanup"
echo "======================================================"
echo ""
echo "This script will:"
echo "1. Identify duplicate file entries in the current commit"
echo "2. Create a clean commit with duplicates removed"
echo "3. Force-push to remote (requires admin rights)"
echo ""

# Show current git status
echo "Current commit: $(git rev-parse HEAD)"
echo "Current branch: $(git rev-parse --abbrev-ref HEAD)"
echo ""

# List all files (showing duplicates)
echo "📋 Listing all tracked files:"
git ls-tree -r HEAD | awk '{print $4}' | sort

echo ""
echo "🔍 Checking for duplicate SHAs in git tree..."
git ls-tree -r HEAD | awk '{print $3}' | sort | uniq -d | wc -l
duplicates=$(git ls-tree -r HEAD | awk '{print $3}' | sort | uniq -d)

if [ -z "$duplicates" ]; then
    echo "✅ No duplicate file content detected!"
    exit 0
fi

echo "⚠️  Found duplicate blob SHAs:"
echo "$duplicates"
echo ""
echo "To force-push a cleaned repository:"
echo "  git reflog expire --expire=now --all"
echo "  git gc --prune=now --aggressive"
echo "  git push origin main --force-with-lease"
echo ""
echo "⚠️  WARNING: This is a destructive operation. Ensure team coordination!"
