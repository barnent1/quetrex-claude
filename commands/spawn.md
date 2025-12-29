---
description: Spawn agent in WezTerm tab with color coding.
allowed-tools: Bash, Read
---

# /spawn <agent-type> [feature-name]

## Valid Types
orchestrator, designer, architect, developer (dev), test-runner (test), qa-fixer (fix), reviewer (review), security

## Execute

```bash
./scripts/wezterm/spawn-agent.sh "{agent}" "$(pwd)" "{feature}"
```

## Manual Instructions (if script unavailable)

1. New WezTerm tab
2. Navigate to project directory
3. Run: `claude`
4. Send: "You are the {agent} agent. Read agents/{agent}.md for your instructions."

## Agent Colors

| Agent | Color | Hex |
|-------|-------|-----|
| Orchestrator | Blue | #3b82f6 |
| Developer | Green | #22c55e |
| Test-Runner | Yellow | #eab308 |
| QA-Fixer | Red | #ef4444 |
| Reviewer | Purple | #a855f7 |
| Architect | Cyan | #06b6d4 |
| Designer | Pink | #ec4899 |
| Security | Orange | #f97316 |
