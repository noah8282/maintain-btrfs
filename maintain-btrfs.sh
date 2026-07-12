#!/bin/bash

set -e

echo "==== 🧹 Starting System Maintenance ===="

# 1. Detect snapshot tool
if command -v snapper &> /dev/null; then
    echo "📸 Using Snapper cleanup..."
    sudo snapper cleanup timeline || true
    sudo snapper cleanup number || true

elif command -v timeshift &> /dev/null; then
    echo "📸 Using Timeshift cleanup..."

    # Keep only latest 3 snapshots (simple approach)
    SNAPSHOTS=$(sudo timeshift --list | grep -E '^[0-9]+' | awk '{print $3}')
    COUNT=$(echo "$SNAPSHOTS" | wc -l)

    if [ "$COUNT" -gt 3 ]; then
        REMOVE=$(echo "$SNAPSHOTS" | head -n -3)
        for snap in $REMOVE; do
            echo "Deleting snapshot: $snap"
            sudo timeshift --delete --snapshot "$snap"
        done
    fi
fi

# 2. Fix pacman leftover directories
echo "🧼 Cleaning broken pacman cache..."
sudo rm -rf /var/cache/pacman/pkg/download-* || true

# 3. Clean package cache (keep last 2 versions)
echo "📦 Cleaning package cache..."
if command -v paccache &> /dev/null; then
    sudo paccache -r
else
    sudo pacman -Sc --noconfirm
fi

# 4. Remove orphan packages
echo "🗑️ Removing orphan packages..."
orphans=$(pacman -Qtdq || true)
if [ -n "$orphans" ]; then
    sudo pacman -Rns --noconfirm $orphans
fi

# 5. Clean user/system cache
echo "🧽 Cleaning cache directories..."
rm -rf ~/.cache/*
sudo rm -rf /var/tmp/*

# 6. Btrfs balance (light)
echo "⚖️ Running Btrfs balance..."
sudo btrfs balance start -dusage=75 -musage=75 / || true

# 7. Btrfs scrub (non-blocking)
echo "🧪 Starting Btrfs scrub..."
sudo btrfs scrub start / || true

echo "==== ✅ Maintenance Complete ===="
