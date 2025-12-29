#!/bin/bash
# Blocks modifications to test files - fix source code, not tests

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // empty')

if [[ "$FILE" == *.test.* ]] || [[ "$FILE" == *.spec.* ]] || [[ "$FILE" == */__tests__/* ]]; then
  echo "{\"decision\":\"block\",\"reason\":\"Test files protected. Fix source code, not tests.\"}"
  exit 0
fi
exit 0
