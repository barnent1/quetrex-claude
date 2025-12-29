#!/bin/bash
# Spawn a complete development session with orchestrator, developer, and test-runner

FEATURE="${1:?Feature name required}"
ISSUE="${2:?Issue number required}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
WORKTREE_DIR="../worktrees/feature-${ISSUE}-${FEATURE}"

# Create worktree if it doesn't exist
if [ ! -d "$WORKTREE_DIR" ]; then
  echo "Creating worktree: $WORKTREE_DIR"
  git worktree add "$WORKTREE_DIR" -b "feature/${ISSUE}-${FEATURE}" 2>/dev/null || \
  git worktree add "$WORKTREE_DIR" "feature/${ISSUE}-${FEATURE}"
fi

WORKTREE_PATH="$(cd "$WORKTREE_DIR" 2>/dev/null && pwd)"

# Spawn agents
echo "Spawning orchestrator..."
ORCH_PANE=$("$SCRIPT_DIR/spawn-agent.sh" orchestrator "$PROJECT_DIR" "$FEATURE")

echo "Spawning developer..."
DEV_PANE=$("$SCRIPT_DIR/spawn-agent.sh" developer "$WORKTREE_PATH" "$FEATURE")

echo "Spawning test-runner..."
TEST_PANE=$("$SCRIPT_DIR/spawn-agent.sh" test-runner "$WORKTREE_PATH" "$FEATURE")

# Save session info
mkdir -p "$PROJECT_DIR/.claude/session"
cat > "$PROJECT_DIR/.claude/session/${FEATURE}.json" << EOF
{
  "feature": "$FEATURE",
  "issue": $ISSUE,
  "worktree": "$WORKTREE_PATH",
  "created": "$(date -Iseconds)",
  "panes": {
    "orchestrator": "$ORCH_PANE",
    "developer": "$DEV_PANE",
    "test-runner": "$TEST_PANE"
  }
}
EOF

echo ""
echo "Development session ready!"
echo "  Feature: $FEATURE"
echo "  Issue: #$ISSUE"
echo "  Worktree: $WORKTREE_PATH"
echo ""
echo "Agents spawned:"
echo "  Orchestrator: pane $ORCH_PANE"
echo "  Developer: pane $DEV_PANE"
echo "  Test-Runner: pane $TEST_PANE"
