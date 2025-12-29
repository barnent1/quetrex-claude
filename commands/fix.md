---
description: Fix failing tests or errors. Delegates to qa-fixer agent.
allowed-tools: Task, Read, Write, Edit, Bash, Grep, Glob
---

# /fix [test-file or error description]

## Process

1. **Identify Failures**
   - Run `pnpm test` if no specific file given
   - Parse error output

2. **Spawn QA-Fixer**
   - Pass failure details
   - Monitor attempts (max 10)

3. **Verify Fix**
   - Re-run tests
   - Run type check: `pnpm tsc --noEmit`
   - Run lint: `pnpm biome check`

4. **Report**
   ```
   ## Fix Complete

   **Fixed:** [count] issues
   **Tests:** All passing
   **Type Check:** Clean
   **Lint:** Clean
   ```

## On Failure (after 10 attempts)
```
## Fix Failed - Escalating

**Attempts:** 10
**Remaining Issues:** [list]

### Tried
[what was attempted]

### Suggested Next Steps
[ideas for manual intervention]
```
