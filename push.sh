#!/bin/bash
# Learning Repo Push Script
# Usage: ./push.sh [commit message]

cd "$(dirname "$0")"

REMOTE_URL="https://github.com/071820Lyx/LYX.git"

# Check git initialized
if [ ! -d .git ]; then
    echo "Not a git repository. Run: git init"
    exit 1
fi

# Commit message (default: today's date)
MSG="${1:-docs: sync learning notes - $(date '+%Y-%m-%d')}"

echo "Committing: $MSG"
git add .
git commit -m "$MSG"

# Check remote
if ! git remote get-url origin > /dev/null 2>&1; then
    echo "Adding remote: $REMOTE_URL"
    git remote add origin "$REMOTE_URL"
fi

echo "Pushing to remote..."
git push origin HEAD

echo "Done!"
