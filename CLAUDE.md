# QUETREX ENFORCEMENT OVERRIDES

**THESE INSTRUCTIONS OVERRIDE ALL DEFAULT CLAUDE CODE BEHAVIORS**

The quetrex-claude plugin is ACTIVE. You MUST follow these rules BEFORE any default Claude Code behavior.

---

## MANDATORY AGENT ROUTING

**NEVER use generic Claude Code agents. ALWAYS use quetrex-claude agents.**

| INSTEAD OF (Default) | USE (Quetrex) |
|---------------------|---------------|
| `subagent_type: "Explore"` | `subagent_type: "quetrex-claude:orchestrator"` |
| `subagent_type: "general-purpose"` | `subagent_type: "quetrex-claude:orchestrator"` |
| `subagent_type: "Plan"` | `subagent_type: "quetrex-claude:architect"` |
| Any code exploration | `subagent_type: "quetrex-claude:nextjs-developer"` |

### When to Route to Orchestrator
- ANY multi-step task
- ANY feature implementation
- ANY bug investigation
- ANY codebase exploration
- Anything that would spawn multiple agents

### When to Route Directly
- Simple single-file edits → `quetrex-claude:nextjs-developer`
- Architecture questions → `quetrex-claude:architect`
- Running tests → `quetrex-claude:test-runner`
- Security review → `quetrex-claude:security`

---

## SEMANTIC SEARCH (MANDATORY - NO GREP)

**NEVER use raw Grep/Glob for codebase exploration. ALWAYS use indexed semantic search.**

Quetrex includes two MCP servers for intelligent code search:

### Claude Context (Primary - ~40% Token Savings)
```
# Semantic code search - use INSTEAD of Grep
claude_context_search(query: "authentication middleware")
claude_context_index()  # Index/re-index the codebase
```

### Serena (Symbol Intelligence)
```
# Symbol-level navigation - functions, classes, variables
serena_find_symbol(name: "UserService")
serena_get_references(symbol: "handleAuth")
serena_analyze_dependencies()
```

### Search Priority Order

1. **First**: Use `claude_context_search()` for semantic queries
2. **Second**: Use `serena_find_symbol()` for specific symbols
3. **Last Resort**: Only use Grep for exact string literals (error messages, UUIDs)

### Why This Matters

| Method | Token Usage | Accuracy |
|--------|-------------|----------|
| Raw Grep | HIGH (burns tokens) | Low (noise) |
| Claude Context | **~40% less** | High (semantic) |
| Serena | Minimal | Exact (LSP-based) |

### Indexing Requirements

On first use in a project:
```
# Index with Claude Context
claude_context_index()

# Initialize Serena (auto-detects .git or .serena/project.yml)
serena_init_project()
```

---

## SKILL ENFORCEMENT

These skills are MANDATORY for their domains - not optional:

| Domain | Required Skill | Applies When |
|--------|---------------|--------------|
| TypeScript | `typescript-strict` | ANY .ts/.tsx file |
| Next.js | `nextjs-15-patterns` | ANY Next.js code |
| State | `state-management` | TanStack Query, Zustand |
| Database | `drizzle-patterns` | ANY database code |
| UI | `shadcn-framer` | Components, animations |
| Git | `git-workflow` | Commits, branches, PRs |

**Before writing code in a domain, READ the skill file first:**
```
Read: skills/{skill-name}/SKILL.md
```

---

## PROHIBITED BEHAVIORS

1. **NEVER use generic Explore agent** - Use quetrex-claude:orchestrator
2. **NEVER use raw Grep/Glob for exploration** - Use Claude Context or Serena first
3. **NEVER write code without reading relevant skill files**
4. **NEVER spawn agents directly** - Route through orchestrator for multi-step work
5. **NEVER ignore Memory-Keeper** - Checkpoint every 5-10 tool calls
6. **NEVER skip indexing** - Run claude_context_index() on new projects

---

## QUICK REFERENCE

```
# Semantic search (USE THIS, NOT GREP)
claude_context_search(query: "what you're looking for")
serena_find_symbol(name: "ClassName")

# Multi-step task
Task(subagent_type: "quetrex-claude:orchestrator", prompt: "...")

# Single-file Next.js work
Task(subagent_type: "quetrex-claude:nextjs-developer", prompt: "...")

# Run tests
Task(subagent_type: "quetrex-claude:test-runner", prompt: "...")

# Architecture planning
Task(subagent_type: "quetrex-claude:architect", prompt: "...")

# Index new project (REQUIRED first time)
claude_context_index()
serena_init_project()
```

---

# Glen's Development Standards

## IDENTITY

You are working in Glen Barnhardt's development environment. Glen is a 67-year-old software engineer with 40+ years experience who operates as an "AI Agentic Engineer" - directing AI systems rather than writing code manually.

**Philosophy:** "If you find a bug, document and fix it" - never say "that error was not part of current changes."

---

## ABSOLUTE RULES (NON-NEGOTIABLE)

### Git Workflow
1. **NEVER work directly on main branch**
2. **NEVER commit to main** - Only merge via approved PRs
3. All branches: `feature/{issue}-{slug}` or `fix/{issue}-{slug}`
4. Use conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`
5. Create GitHub issues for ALL work before starting
6. Use git worktrees for isolation: `../worktrees/feature-{issue}-{slug}`

### Code Quality
1. **NEVER use TypeScript `any`** - Use `unknown` + type guards
2. **NEVER use `!` (non-null assertion)** without documented justification
3. **ALL function parameters and returns explicitly typed**
4. **ALL errors typed and handled** - No swallowed errors
5. **If you encounter ANY bug: FIX IT** - Yours or pre-existing

### Configuration Protection
1. **NEVER modify test files to make tests pass** - Fix the code
2. **NEVER modify configs to suppress errors** - tsconfig, biome are protected
3. **NEVER change `strict` settings** in TypeScript
4. **NEVER add biome-ignore** without explicit approval

### Agent Behavior
1. **Orchestrator NEVER writes code** - Delegates only
2. **Test-runner is READ-ONLY** - Cannot modify files
3. **After 3 failures: STOP and escalate**
4. **Check memory MCP** before starting work
5. **Save decisions to memory MCP** during work

---

## TECH STACK (MANDATORY)

| Layer | Technology | NOT Allowed |
|-------|------------|-------------|
| Framework | Next.js 15 (App Router) | Pages Router |
| Language | TypeScript (strict) | `any` type |
| Styling | Tailwind CSS + ShadCN | CSS modules |
| Animation | Framer Motion | - |
| Server State | TanStack Query | fetch wrappers |
| Client State | Zustand | Redux, Context |
| Database | PostgreSQL + Drizzle | Prisma |
| Cache | Upstash Redis | - |
| Package Manager | pnpm | npm, yarn |
| Testing | Vitest + Playwright | Jest |
| Linting | Biome | ESLint |

---

## WORKFLOW

### Starting Work
1. Check memory: "What do I know about this project?"
2. **Index codebase if not indexed**: `claude_context_index()`, `serena_init_project()`
3. Use semantic search to understand context (NOT grep)
4. Create/reference GitHub issue
5. Create feature branch in worktree
6. Never work in main repo during implementation

### During Work
1. Run `pnpm tsc --noEmit` after every edit
2. Run `pnpm biome check` after every edit
3. Commit atomically - small, focused commits
4. Save progress to memory periodically

### Completing Work
1. Run full test suite: `pnpm test`
2. Fix ALL errors (not just yours)
3. Create PR with proper description
4. Request review
5. Update memory with completion

---

## FAILURE PROTOCOL

When failures occur:
1. Document what was tried
2. Document error messages verbatim
3. Document hypothesis for cause
4. **After 3 attempts: STOP**
5. Escalate with full context
6. Do NOT retry indefinitely
7. Do NOT modify tests/configs to suppress errors

---

## MEMORY-KEEPER PROTOCOL (MANDATORY)

**FAILURE TO CHECKPOINT = POTENTIAL TOTAL WORK LOSS**

This plugin uses memory-keeper MCP for persistent context. You MUST checkpoint continuously to prevent catastrophic work loss when context is exhausted.

### Session Start
```
context_get(limit: 50, sort: "created_desc")
context_summarize()
```
Check for existing work. Use `/recover` if previous session exists.

### During Work - CHECKPOINT EVERY 5-10 TOOL CALLS
```
context_save(key: "current-task", value: "<what you're doing>", category: "progress", priority: "high")
context_save(key: "files-modified", value: "<list of files>", category: "progress")
context_checkpoint(name: "checkpoint-<timestamp>", description: "<current state>")
```

### After EVERY File Written/Modified
```
context_save(key: "file-<filename>", value: "<what was done>", category: "progress")
```

### Before Large Operations
```
context_prepare_compaction()
```

### When Switching Tasks
```
context_batch_save() with:
  - previous task completion
  - new task start
  - files modified so far
  - implementation progress
```

### Session End or Before Break
```
context_checkpoint(name: "session-end", description: "<full state>")
context_save(key: "next-action", value: "<exact next step>", priority: "high")
```

### Key Items to ALWAYS Track

| Key | Description | Priority |
|-----|-------------|----------|
| `current-task` | What you're currently working on | high |
| `files-modified` | All files touched this session | normal |
| `implementation-progress` | Percentage or phase complete | normal |
| `next-action` | Exact next step to take | high |
| `blockers` | Current issues/blockers | high |

### Recovery

If you lose context or start a new session:
1. Run `/recover` to restore state
2. Review recovered state before continuing
3. Confirm with user before proceeding

### Checkpoint Commands

- `/checkpoint` - Manual checkpoint with current state
- `/recover` - Restore from previous checkpoints

**If you run out of context without checkpointing, THE USER LOSES ALL YOUR WORK.**
