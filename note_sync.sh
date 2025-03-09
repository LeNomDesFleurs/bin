#!/bin/bash

# Directory where your notes are stored
NOTES_DIR="~/FILES/NOTE"

# Navigate to the notes directory
cd "$NOTES_DIR" || exit

# Pull the latest changes from the server
echo "Pulling latest changes..."
git pull --rebase || { echo "Pull failed. Aborting."; exit 1; }

# Add any new or modified files
echo "Adding new or modified files..."
git add .

# Commit changes (if any)
echo "Committing changes..."
git commit -m "Auto-sync $(date)" || echo "No changes to commit."

# Push changes to the server
echo "Pushing changes..."
git push || { echo "Push failed. Aborting."; exit 1; }

echo "Sync complete!"