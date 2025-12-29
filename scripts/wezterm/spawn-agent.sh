#!/bin/bash
# Spawn a Claude Code agent in a new WezTerm tab with color coding

AGENT="${1:?Agent type required (orchestrator, developer, test-runner, etc.)}"
WORK_DIR="${2:?Directory required}"
FEATURE="${3:-}"

# Normalize agent name
AGENT_LOWER=$(echo "$AGENT" | tr '[:upper:]' '[:lower:]')
AGENT_UPPER=$(echo "$AGENT" | tr '[:lower:]' '[:upper:]')

# Build tab title
if [ -n "$FEATURE" ]; then
  TITLE="${AGENT_UPPER}: ${FEATURE}"
else
  TITLE="${AGENT_UPPER}"
fi

# Spawn new pane in WezTerm
PANE_ID=$(wezterm cli spawn --cwd "$WORK_DIR")

# Set tab title
wezterm cli set-tab-title --pane-id "$PANE_ID" "$TITLE"

# Wait for shell to be ready
sleep 1

# Start Claude Code
echo "claude" | wezterm cli send-text --pane-id "$PANE_ID" --no-paste

# Wait for Claude to initialize
sleep 2

# Send agent instructions
INSTRUCTIONS="You are the ${AGENT_LOWER} agent. Read agents/${AGENT_LOWER}.md for your role and instructions."
if [ -n "$FEATURE" ]; then
  INSTRUCTIONS="${INSTRUCTIONS} You are working on: ${FEATURE}"
fi

echo "$INSTRUCTIONS" | wezterm cli send-text --pane-id "$PANE_ID" --no-paste

echo "Spawned ${AGENT} agent in pane ${PANE_ID}"
echo "$PANE_ID"
