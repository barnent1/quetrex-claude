#!/bin/bash
# Prevents commits and pushes on main/master branch

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.command // empty')

if [[ "$COMMAND" == git* ]]; then
  BRANCH=$(git branch --show-current 2>/dev/null)
  if [ "$BRANCH" = "main" ] || [ "$BRANCH" = "master" ]; then
    if [[ "$COMMAND" == *"commit"* ]] || [[ "$COMMAND" == *"push"* ]]; then
      echo "BLOCKED: Cannot '$COMMAND' on main. Create feature branch first." >&2
      exit 2
    fi
  fi
fi
exit 0
