#!/usr/bin/env bash
#
# harness-kit installer — copies the skills and commands in this repo into
# your Claude Code config (~/.claude/). Existing files with the same name are
# backed up first, never silently overwritten.
#
set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="${CLAUDE_DIR}/.harness-kit-backup-${STAMP}"

mkdir -p "${CLAUDE_DIR}/skills" "${CLAUDE_DIR}/commands"

backup_if_exists() {
  local target="$1"
  if [ -e "$target" ]; then
    local rel="${target#"${CLAUDE_DIR}"/}"
    mkdir -p "${BACKUP}/$(dirname "$rel")"
    cp -R "$target" "${BACKUP}/${rel}"
    echo "    ↳ backed up existing $(basename "$target")"
  fi
}

echo "Installing skills into ${CLAUDE_DIR}/skills …"
for dir in "${SRC}"/skills/*/; do
  name="$(basename "$dir")"
  backup_if_exists "${CLAUDE_DIR}/skills/${name}"
  rm -rf "${CLAUDE_DIR}/skills/${name}"
  cp -R "$dir" "${CLAUDE_DIR}/skills/${name}"
  echo "  ✓ ${name}"
done

echo "Installing commands into ${CLAUDE_DIR}/commands …"
for file in "${SRC}"/commands/*.md; do
  name="$(basename "$file")"
  backup_if_exists "${CLAUDE_DIR}/commands/${name}"
  cp "$file" "${CLAUDE_DIR}/commands/${name}"
  echo "  ✓ /${name%.md}"
done

if [ -d "$BACKUP" ]; then
  echo ""
  echo "Some files already existed and were backed up to:"
  echo "  ${BACKUP}"
fi

echo ""
echo "Done. Restart Claude Code (or start a new session) to pick up the new skills and commands."
