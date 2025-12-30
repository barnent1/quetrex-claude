# Blockers & Mistakes Log

**PURPOSE:** Record failed attempts and mistakes to prevent repetition.

Before attempting ANY fix, the memory-curator checks this file. If your proposed fix matches a past mistake, it will be BLOCKED.

---

## Template

```markdown
## [Date] - [Brief Description]

**Issue:** [What problem we were trying to solve]

**Attempted Fix:** [What we tried]

**Result:** WRONG - [Why it failed]

**Root Cause:** [What we misunderstood]

**Correct Approach:** [What should be done instead]

**Files Involved:**
- `path/to/file.ts`

**Tags:** [auth, database, ui, api, etc.]

---
DO NOT REPEAT THIS MISTAKE.
---
```

---

## Mistakes Log

<!-- Add new entries at the top -->

### Example Entry

## 2024-01-15 - Fixed Wrong Auth File

**Issue:** Login was failing with 401 errors

**Attempted Fix:** Modified `src/app/api/auth/login/route.ts` to fix token generation

**Result:** WRONG - This file is legacy code, not in use

**Root Cause:** Search returned multiple "auth" files, picked the wrong one without checking architecture-truth.md

**Correct Approach:**
1. Check architecture-truth.md - auth is in `src/lib/auth/`
2. The actual auth handler is `src/lib/auth/session.ts`
3. The API route is legacy and should be deleted

**Files Involved:**
- `src/app/api/auth/login/route.ts` (LEGACY - DO NOT USE)
- `src/lib/auth/session.ts` (CORRECT LOCATION)

**Tags:** auth, legacy-code, wrong-file

---
DO NOT REPEAT THIS MISTAKE.
---

---

## Common Mistake Patterns

### Pattern: Wrong File from Search
**Symptom:** Search returns multiple files, wrong one is modified
**Prevention:** Always verify against architecture-truth.md before modifying

### Pattern: Fixing Symptoms Not Cause
**Symptom:** Fix "works" but problem returns or moves elsewhere
**Prevention:** Trace to root cause, don't patch symptoms

### Pattern: Modifying Generated/Vendored Code
**Symptom:** Changes get overwritten on next build/install
**Prevention:** Check if file is in .gitignore or generated comment

### Pattern: Breaking Change Without Migration
**Symptom:** Database errors, type mismatches after schema change
**Prevention:** Always use migrations, never edit schema directly

---

## Search Before Fixing

Use this to check if your fix has been tried:

```
mcp__serena__search_for_pattern(
  substring_pattern: "[describe your fix approach]"
)
```

If this file contains a matching entry, STOP and read it first.

---

<!-- Add your project's blockers below -->
