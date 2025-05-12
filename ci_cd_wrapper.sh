#!/bin/bash
PROJECT_PATH="/var/www/Building-CI-CD-Pipeline-Tool"

python3 "$PROJECT_PATH/check_github.py"

if [ $? -eq 0 ]; then
    echo "✅ Changes detected. Updating website..."
    bash "$PROJECT_PATH/update_website.sh"
else
    echo "ℹ️ No changes detected. No update needed."
fi