#!/bin/bash
# Create a git worktree for isolated development

ISSUE="${1:?Issue number required}"
SLUG="${2:?Feature slug required}"

BRANCH_NAME="feature/${ISSUE}-${SLUG}"
WORKTREE_PATH="../worktrees/feature-${ISSUE}-${SLUG}"

# Check if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "Error: Not in a git repository"
  exit 1
fi

# Check if worktree already exists
if [ -d "$WORKTREE_PATH" ]; then
  echo "Worktree already exists: $WORKTREE_PATH"
  echo "Use: cd $WORKTREE_PATH"
  exit 0
fi

# Create worktree
echo "Creating worktree: $WORKTREE_PATH"
git worktree add "$WORKTREE_PATH" -b "$BRANCH_NAME" 2>/dev/null || \
git worktree add "$WORKTREE_PATH" "$BRANCH_NAME"

if [ $? -eq 0 ]; then
  FULL_PATH="$(cd "$WORKTREE_PATH" && pwd)"
  echo ""
  echo "Worktree created successfully!"
  echo "  Path: $FULL_PATH"
  echo "  Branch: $BRANCH_NAME"
  echo ""
  echo "To start working:"
  echo "  cd $WORKTREE_PATH"
else
  echo "Failed to create worktree"
  exit 1
fi
