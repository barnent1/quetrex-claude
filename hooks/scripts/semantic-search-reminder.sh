#!/bin/bash
# Semantic search reminder hook
# Warns when Grep/Glob is used instead of Claude Context or Serena

cat <<EOF

---
**SEMANTIC SEARCH PREFERRED**: You just used Grep/Glob which burns tokens.

Use indexed semantic search instead for ~40% token savings:

\`\`\`
# Claude Context - semantic code search
claude_context_search(query: "what you're looking for")

# Serena - symbol-level navigation
serena_find_symbol(name: "ClassName")
serena_get_references(symbol: "functionName")
\`\`\`

Only use Grep for exact string matches (error messages, UUIDs).
---

EOF

exit 0
