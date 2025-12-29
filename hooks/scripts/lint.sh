#!/bin/bash
# Runs Biome linting after file edits

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // empty')

if [[ "$FILE" == *.ts ]] || [[ "$FILE" == *.tsx ]] || [[ "$FILE" == *.js ]] || [[ "$FILE" == *.jsx ]]; then
  pnpm biome check "$FILE" 2>&1
  if [ $? -ne 0 ]; then
    echo "Linting errors. Fix before continuing." >&2
    exit 1
  fi
fi
exit 0
