# Architectural Decisions

This document records WHY we made certain choices. Reference this before reconsidering past decisions.

---

## Template

```markdown
## [Date] - [Decision Title]

**Context:** [What situation required a decision]

**Options Considered:**
1. [Option A] - [pros/cons]
2. [Option B] - [pros/cons]

**Decision:** [What we chose]

**Reasoning:** [Why we chose it]

**Consequences:** [What this means going forward]

**Status:** [Active / Superseded by X / Deprecated]
```

---

## Decisions Log

<!-- Add new decisions at the top -->

### Example Entry

## 2024-01-15 - Use Zustand over Redux

**Context:** Needed client-side state management for UI state.

**Options Considered:**
1. Redux - Established, lots of boilerplate, overkill for our needs
2. Zustand - Simple, minimal boilerplate, TypeScript native
3. Jotai - Atomic model, different mental model
4. React Context - Built-in, but causes unnecessary re-renders

**Decision:** Zustand

**Reasoning:**
- Minimal boilerplate matches our "avoid over-engineering" principle
- TypeScript support is excellent out of the box
- Can be used outside React components
- Glen's tech stack specifies Zustand

**Consequences:**
- All client state goes in `src/stores/`
- Never use React Context for state
- Can access stores from server actions if needed

**Status:** Active

---

<!-- Add your project's decisions below -->
