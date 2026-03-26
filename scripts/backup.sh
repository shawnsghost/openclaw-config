#!/bin/bash
# Daily backup script for OpenClaw workspace
# Creates a git tag with today's date and pushes to GitHub

REPO_DIR="/tmp/openclaw-config"
WORKSPACE_DIR="$HOME/.openclaw/workspace"
BACKUP_LOG="$HOME/.openclaw/logs/backup.log"

# Ensure log directory exists
mkdir -p "$(dirname $BACKUP_LOG)"

echo "=== Backup started: $(date) ===" >> "$BACKUP_LOG"

# Sync workspace files to git repo
cp -r "$WORKSPACE_DIR"/* "$REPO_DIR/" 2>/dev/null

cd "$REPO_DIR" || exit 1

# Stage all changes
git add -A

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo "No changes to commit" >> "$BACKUP_LOG"
else
    # Commit with timestamp
    git commit -m "Workspace backup: $(date +%Y-%m-%d\ %H:%M)"

    # Create or update dated tag
    TAG_NAME="backup-$(date +%Y-%m-%d)"
    git tag -f "$TAG_NAME"

    # Push commits and tags to GitHub
    git push origin master --tags 2>&1 | tee -a "$BACKUP_LOG"

    echo "Backup complete: $TAG_NAME" >> "$BACKUP_LOG"
fi

echo "=== Backup finished: $(date) ===" >> "$BACKUP_LOG"
