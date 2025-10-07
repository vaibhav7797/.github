#!/usr/bin/env bash
# Exit on error, undefined variable, or pipe failure
set -euo pipefail

# Get current branch name
branch="$(git rev-parse --abbrev-ref HEAD)"

# -------------------------------
# Whitelist pre-commit CI branches
# -------------------------------
if [[ "$branch" =~ ^pre-commit-ci- ]]; then
  echo "✅ Whitelisted branch: $branch"
  exit 0
fi

# Regex pattern: feature|bugfix|chore|hotfix + optional JIRA key or slug
regex='^(feature|bugfix|chore|hotfix)\/([A-Z]+-[0-9]+-.+|[a-z0-9._-]+)$'

# Validate branch name
if [[ ! "$branch" =~ $regex ]]; then
  echo ":x: Invalid branch name: $branch
Allowed patterns: feature|bugfix|chore|hotfix
Example: feature/ABC-123-add-metrics"
  exit 1
fi

echo "✅ Branch name is valid: $branch"
