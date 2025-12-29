---
description: Plan a feature with design + architecture. Human approves before build.
allowed-tools: Task, Read, Write, Bash, Grep, Glob
---

# /plan <feature description>

## Process

1. **Spawn Designer**
   - User flow, UI mockups, components
   - Present for human feedback

2. **Spawn Architect**
   - Technical spec, data model, API design
   - Test plan (tests first)
   - Save to `.claude/specs/{slug}.md`

3. **Human Approval**
   ```
   ## Feature Plan: [name]

   ### Design
   [output]

   ### Architecture
   [output]

   Ready? Reply "approved" or provide feedback.
   ```

4. **On Approval**
   - Create GitHub issue
   - Save to memory
   - Prompt: `/build {issue-number}`
