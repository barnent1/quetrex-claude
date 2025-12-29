---
description: Autonomous build from approved spec. Human OUT of loop until done.
allowed-tools: Task, Read, Write, Bash, Grep, Glob
---

# /build <issue-number>

## Pre-flight
- Verify issue exists
- Verify spec exists
- Not on main
- Clean git status

## Setup
```bash
git worktree add "../worktrees/feature-{issue}-{slug}" -b "feature/{issue}-{slug}"
```

## Execution

1. **Spawn Developer** in worktree
2. **Monitor** via memory
3. **On Complete**: Spawn test-runner
4. **If Fail**: Spawn qa-fixer (max 10x)
5. **On Pass**: Spawn reviewer
6. **On Review Pass**: Create PR

```bash
gh pr create --title "feat: {title}" --body "Closes #{issue}" --base main
```

## Notify Human
```
## Build Complete

**PR:** #{number}
**Branch:** feature/{issue}-{slug}

Review at: ../worktrees/feature-{issue}-{slug}
```

## On Failure
```
## Build Failed

**Failed At:** [stage]
**Error:** [details]
**Tried:** [list]

Recovery: Fix manually or restart
```
