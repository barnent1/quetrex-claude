# Enforced Rules

**THESE RULES ARE NON-NEGOTIABLE. VIOLATIONS WILL BLOCK EXECUTION.**

The memory-curator agent re-injects these rules at every session start. They cannot be "forgotten."

---

## BLOCKING RULES

These rules **HALT EXECUTION** if violated. No exceptions.

### B1: Never Modify Test Files to Pass Tests
```
BLOCKED: Any edit to *.test.ts, *.spec.ts, *.test.tsx, *.spec.tsx
REASON: Tests define expected behavior. Fix the code, not the tests.
EXCEPTION: Only when explicitly adding NEW test cases.
```

### B2: Never Use TypeScript `any`
```
BLOCKED: any type in TypeScript files
REASON: Defeats type safety. Use `unknown` with type guards.
EXCEPTION: None. Find the correct type.
```

### B3: Never Commit to Main Branch
```
BLOCKED: git commit on main/master branch
REASON: All changes go through PRs.
EXCEPTION: None. Create a feature branch.
```

### B4: Never Modify Config to Suppress Errors
```
BLOCKED: Changes to tsconfig.json, biome.json that weaken strictness
REASON: Configs are protected. Fix the code.
EXCEPTION: Only with explicit user approval.
```

### B5: Never Touch Legacy/Deprecated Code
```
BLOCKED: Modifications to paths marked "DO NOT USE" in architecture-truth.md
REASON: Legacy code should be deleted, not fixed.
EXCEPTION: Only for deletion/removal.
```

### B6: Never Add biome-ignore Without Approval
```
BLOCKED: Adding biome-ignore comments
REASON: Fix the issue, don't suppress it.
EXCEPTION: Only with explicit user approval and documented reason.
```

---

## VERIFY-FIRST RULES

These rules require **verification before acting**. Spawn memory-curator with "verify-fix" task.

### V1: Before Fixing Any Bug
```
VERIFY:
1. Is this file in the correct location per architecture-truth.md?
2. Is this the ACTUAL source of the bug, not just related code?
3. Have we attempted this fix before? (check blockers.md)

IF ANY ANSWER IS UNCLEAR: Ask the user before proceeding.
```

### V2: Before Modifying Auth Code
```
VERIFY:
1. Am I in src/lib/auth/ (not src/app/api/auth/)?
2. Have I read architecture-truth.md#authentication?
3. Does this change affect session handling?

IF AFFECTS SESSIONS: Requires extra review.
```

### V3: Before Database Schema Changes
```
VERIFY:
1. Am I creating a migration, not editing schema directly?
2. Is this backward compatible?
3. Have I considered existing data?

IF NOT MIGRATION: BLOCKED. Create migration instead.
```

### V4: Before Adding New Dependencies
```
VERIFY:
1. Is there an existing solution in the codebase?
2. Is this the standard package for this stack?
3. Is it actively maintained?

PREFERRED PACKAGES:
- Forms: react-hook-form + zod
- State: zustand, @tanstack/react-query
- UI: shadcn/ui components
- Date: date-fns
- HTTP: Native fetch (no axios)
```

### V5: Before Creating New Files
```
VERIFY:
1. Does similar functionality already exist?
2. Is the location correct per architecture-truth.md?
3. Does the naming follow conventions?

IF FILE EXISTS: Extend it, don't duplicate.
```

### V6: Before "Fixing" Code Found via Search
```
VERIFY:
1. Did search return multiple results?
2. Am I CERTAIN this is the right file?
3. Does architecture-truth.md confirm this location?

IF UNCERTAIN: Ask user "Is [file] the correct location for [feature]?"
```

---

## DIRECTIVE RULES

These are standing orders that apply always.

### D1: Philosophy
```
"If you find a bug, document and fix it."
Never say "that error was not part of current changes."
```

### D2: Search Priority
```
1. Use Serena's semantic tools (find_symbol, search_for_pattern)
2. Check architecture-truth.md for correct locations
3. Only use Grep as last resort for exact strings
```

### D3: Before Writing Code
```
1. Read relevant skill files
2. Check architecture-truth.md
3. Verify no existing implementation
4. Use memory-curator verify-fix if modifying existing code
```

### D4: After Every Edit
```
1. Run: pnpm tsc --noEmit
2. Run: pnpm biome check
3. Fix ALL errors before proceeding
```

### D5: Error Handling
```
- Never swallow errors
- Never use empty catch blocks
- Always type errors as `unknown`
- Log meaningful context
```

### D6: State Management
```
- Server state: TanStack Query
- Client state: Zustand
- Never use React Context for state
- Never prop drill more than 2 levels
```

---

## RECORDING VIOLATIONS

When a rule is violated (accidentally or discovered later):

1. Stop current work
2. Record in blockers.md:
   ```markdown
   ## [Date] - Rule Violation: [RULE ID]

   **What happened:** [description]
   **Why it was wrong:** [explanation]
   **Corrective action:** [what was done to fix]
   **Prevention:** [how to avoid in future]
   ```
3. Fix the violation
4. Continue work

---

## RULE MODIFICATION

These rules can ONLY be modified by:
1. Explicit user request
2. With documented reasoning
3. After considering consequences

Never weaken rules to make a task easier. If a rule is blocking legitimate work, discuss with the user.
