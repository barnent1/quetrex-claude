# Quetrex for Claude Code

A hardened Claude Code plugin for autonomous Next.js 15 development with multi-agent orchestration.

**Created by Glen Barnhardt with the help of Claude Code**

## Features

- **Multi-Agent Orchestration** - Parallel autonomous development via WezTerm tabs
- **Strict TypeScript Enforcement** - No `any`, explicit types, proper error handling
- **Git Workflow Protection** - Never work on main, always use feature branches/worktrees
- **Test/Config Guards** - Cannot modify tests to make them pass
- **Persistent Memory** - Never lose context across sessions via MCP
- **LSP Integration** - Stop repetitive codebase searching

## Installation

```bash
# Clone the repository
git clone https://github.com/barnent1/quetrex-claude.git

# Install as Claude Code plugin
claude plugin install ./quetrex-claude
```

## Commands

| Command | Description |
|---------|-------------|
| `/init` | Initialize project with Quetrex standards |
| `/plan <feature>` | Design + architecture with human approval |
| `/build <issue>` | Autonomous implementation from spec |
| `/fix [target]` | Fix failing tests or errors |
| `/spawn <agent>` | Spawn agent in WezTerm tab |
| `/status` | Check session and agent status |
| `/ship [issue]` | Create PR with final checks |
| `/create-term-project` | Create WezTerm tab config |
| `/change-term-tab-color` | Change WezTerm tab color |

## Agents

| Agent | Role | Color |
|-------|------|-------|
| Orchestrator | Coordinates work, NEVER writes code | Blue |
| Designer | UI prototypes and user flows | Pink |
| Architect | Technical specs, tests-first design | Cyan |
| Developer | Next.js 15 implementation | Green |
| Test-Runner | Execute tests (READ-ONLY) | Yellow |
| QA-Fixer | Fix code to pass tests (can't modify tests) | Red |
| Reviewer | Code review and quality gate | Purple |
| Security | Security audit and scanning | Orange |

## Tech Stack (Mandatory)

| Layer | Technology |
|-------|------------|
| Framework | Next.js 15 (App Router) |
| Language | TypeScript (strict) |
| Styling | Tailwind CSS + ShadCN |
| Animation | Framer Motion |
| Server State | TanStack Query |
| Client State | Zustand |
| Database | PostgreSQL + Drizzle |
| Cache | Upstash Redis |
| Package Manager | pnpm |
| Testing | Vitest + Playwright |
| Linting | Biome |

## Skills

- `typescript-strict` - Strict TypeScript rules
- `nextjs-15-patterns` - App Router patterns and best practices
- `state-management` - TanStack Query + Zustand patterns
- `drizzle-patterns` - Drizzle ORM for PostgreSQL
- `shadcn-framer` - ShadCN UI + Framer Motion
- `redis-patterns` - Upstash Redis caching
- `git-workflow` - Worktrees and conventional commits

## Workflow

### Starting a Feature

1. **Plan**: `/plan add user authentication`
   - Designer creates UI mockups
   - Architect creates technical spec
   - Human approves before coding

2. **Build**: `/build 42`
   - Creates worktree: `../worktrees/feature-42-auth`
   - Developer implements from spec
   - Test-runner validates
   - QA-fixer resolves issues
   - Reviewer approves

3. **Ship**: `/ship 42`
   - Final quality checks
   - Creates PR: `gh pr create`

### Multi-Agent Session

```bash
# Spawn a complete dev session
./scripts/wezterm/spawn-dev-session.sh auth 42

# Or spawn individual agents
/spawn orchestrator auth
/spawn developer auth
/spawn test-runner auth
```

## WezTerm Integration

Tab colors indicate agent type:
- **Selected tab**: Green dot + colored text
- **Unselected tab**: Colored background + black text

Colors are read from `.wezterm/project.md` or detected from agent type.

## Configuration

### MCP Servers

- `memory-keeper` - Persistent project memory
- `github` - GitHub integration for issues/PRs

### Hooks

- `enforce-branch.sh` - Blocks commits on main
- `typecheck.sh` - Runs `tsc --noEmit` after edits
- `lint.sh` - Runs `biome check` after edits
- `config-guard.sh` - Protects config files
- `test-guard.sh` - Protects test files

## License

MIT
