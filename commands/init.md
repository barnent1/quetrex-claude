---
description: Initialize project with Quetrex standards. Run first in any project.
allowed-tools: Bash, Read, Write, Glob, Grep
---

# /init - Project Initialization

## Steps

1. **Verify Git**
   - Must be git repo
   - Must NOT be on main (switch to develop if needed)

2. **Verify Stack**
   - next (v15+), typescript, @tanstack/react-query, zustand, drizzle-orm
   - Report missing deps

3. **Verify tsconfig**
   - `strict: true` must be set

4. **Create Directories**
   ```bash
   mkdir -p .claude/{memory,specs,signals,session,skills/codebase-map}
   ```

5. **Build Codebase Map**
   - Scan structure
   - Document patterns
   - Save to `.claude/skills/codebase-map/SKILL.md`

6. **Initialize Memory**
   - Project name, stack, key decisions

7. **Report**
   ```
   ## Initialization Complete

   **Project:** [name]
   **Stack:** Verified

   Run `/plan <feature>` to start.
   ```
