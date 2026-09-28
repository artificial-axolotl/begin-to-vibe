#!/usr/bin/env bash
set -euo pipefail

# Install Claude Code with the official native installer
curl -fsSL https://claude.ai/install.sh | bash

# Codespaces sets BROWSER to a VS Code helper, so Claude Code's login tries to
# redirect back to http://localhost, which points at the student's own machine
# and fails. BROWSER names the program used to open URLs, and `true` is a
# no-op command that just exits successfully, so no browser opens. Claude Code
# then shows a sign-in link and a "paste code here" prompt instead.
for rc in ~/.bashrc ~/.zshrc; do
  if ! grep -q "BeginToVibe: claude login" "$rc" 2>/dev/null; then
    cat >> "$rc" <<'EOF'

# BeginToVibe: claude login uses copy-paste code instead of localhost redirect
claude() { BROWSER=true command claude "$@"; }
EOF
  fi
done
