#!/bin/bash
# Blocks modifications to protected config files

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // empty')
FILENAME=$(basename "$FILE")

PROTECTED="tsconfig.json biome.json biome.jsonc eslint.config.js .eslintrc vitest.config.ts vitest.config.js"
for p in $PROTECTED; do
  if [[ "$FILENAME" == "$p"* ]]; then
    echo "{\"decision\":\"block\",\"reason\":\"Protected config: $FILENAME\"}"
    exit 0
  fi
done
exit 0
