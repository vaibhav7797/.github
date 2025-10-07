#!/usr/bin/env bash
# Exit on error, undefined variable, or pipefail
set -euo pipefail

# Get the latest commit message title (first line)
pr_title="$(git log -1 --pretty=%s)"

# -------------------------------
# Whitelist pre-commit.ci commits
# -------------------------------
if [[ "$pr_title" =~ ^\[pre-commit\.ci\] ]]; then
  echo "✅ Whitelisted commit: $pr_title"
  exit 0
fi

# Regex pattern for Conventional Commits
# Format: type(scope?): subject
regex='^(feat|fix|chore|docs|style|refactor|perf|test|ci)(\([a-z0-9._-]+\))?: .+'

# Validate PR title
if [[ ! "$pr_title" =~ $regex ]]; then
  echo ":x: Invalid PR title: $pr_title"
  echo "Must follow conventional commit format: type(scope?): subject"
  echo "Example: feat(core): add new validation"
  exit 1
fi

echo "✅ PR title is valid: $pr_title"
