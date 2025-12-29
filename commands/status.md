---
description: Check status of current development session and agents.
allowed-tools: Bash, Read, Grep, Glob
---

# /status

## Check

1. **Git Status**
   ```bash
   git branch --show-current
   git status --short
   git worktree list
   ```

2. **Active Worktrees**
   - List all worktrees
   - Show which have uncommitted changes

3. **Session State**
   - Read `.claude/session/*.json`
   - Show active agents

4. **Test Status**
   ```bash
   pnpm test --run 2>&1 | tail -20
   ```

5. **Type Check Status**
   ```bash
   pnpm tsc --noEmit 2>&1 | tail -20
   ```

## Output Format

```
## Session Status

### Git
**Branch:** feature/42-auth
**Status:** Clean / 3 modified files
**Worktrees:**
- main (~/projects/myapp)
- feature-42-auth (~/projects/worktrees/feature-42-auth)

### Agents
- Orchestrator: Active (pane 1)
- Developer: Active (pane 2)
- Test-Runner: Idle

### Quality
- Tests: 45 passing, 0 failing
- Type Check: Clean
- Lint: Clean

### Recent Activity
[from memory]
```
