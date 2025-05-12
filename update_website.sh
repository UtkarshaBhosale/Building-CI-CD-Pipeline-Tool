#!/bin/bash
REPO_URL="https://github.com/UtkarshaBhosale/Building-CI-CD-Pipeline-Tool.git"
REPO_DIR="/var/www/Building-CI-CD-Pipeline-Tool"
WEBSITE_DIR="/var/www/html"
BRANCH_NAME="main"
LAST_COMMIT="$REPO_DIR/last_commit.txt"

# Create repo dir if it doesn't exist
if [ ! -d "$REPO_DIR" ]; then
    echo "Creating repo directory: $REPO_DIR"
    mkdir -p "$REPO_DIR"
fi

cd "$REPO_DIR" || { echo "❌ Failed to enter $REPO_DIR"; exit 1; }

if git config --get remote.origin.url &>/dev/null; then
    git fetch origin
    git reset --hard "origin/$BRANCH_NAME"
else
    echo "Cloning repository into $REPO_DIR..."
    git clone $REPO_URL .
fi

if [ ! -f "$LAST_COMMIT" ]; then
    sudo touch "$LAST_COMMIT"
    echo "📄 Created: $LAST_COMMIT"
fi

rsync -av --delete $REPO_DIR/ $WEBSITE_DIR/
sudo systemctl restart nginx

echo "✅ Website updated successfully"