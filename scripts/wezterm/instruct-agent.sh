#!/bin/bash
# Send instructions to an existing agent pane

PANE_ID="${1:?Pane ID required}"
MESSAGE="${2:?Message required}"

echo "$MESSAGE" | wezterm cli send-text --pane-id "$PANE_ID" --no-paste
