#!/bin/bash
# Runs TypeScript type checking after file edits

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // empty')

if [[ "$FILE" == *.ts ]] || [[ "$FILE" == *.tsx ]]; then
  pnpm tsc --noEmit 2>&1
  if [ $? -ne 0 ]; then
    echo "TypeScript errors. Fix before continuing." >&2
    exit 1
  fi
fi
exit 0
