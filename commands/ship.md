---
description: Create PR and prepare for merge. Final quality checks.
allowed-tools: Bash, Read, Grep, Glob, Task
---

# /ship [issue-number]

## Pre-flight Checks

1. **Not on main**
   ```bash
   BRANCH=$(git branch --show-current)
   if [ "$BRANCH" = "main" ]; then
     echo "ERROR: Cannot ship from main"
     exit 1
   fi
   ```

2. **Clean git status**
   ```bash
   git status --porcelain
   ```

3. **All tests pass**
   ```bash
   pnpm test --run
   ```

4. **Type check clean**
   ```bash
   pnpm tsc --noEmit
   ```

5. **Lint clean**
   ```bash
   pnpm biome check
   ```

## Spawn Reviewer

Run final code review before PR.

## Create PR

```bash
gh pr create \
  --title "feat: {title from spec}" \
  --body "$(cat <<EOF
## Summary
{brief description}

## Changes
- {change 1}
- {change 2}

## Test Plan
- [ ] Unit tests pass
- [ ] E2E tests pass
- [ ] Manual testing completed

Closes #{issue}
EOF
)" \
  --base main
```

## Report

```
## Ready to Ship

**PR:** #{number}
**URL:** {url}
**Branch:** {branch}

### Checks
- Tests: Passing
- Types: Clean
- Lint: Clean
- Review: Approved

Awaiting merge approval.
```
