#!/usr/bin/env bash

set -euo pipefail

REPO="noah8282/maintain-btrfs"
BRANCH="main"

SCRIPT_NAME="maintain-btrfs.sh"
INSTALL_PATH="/usr/local/bin/$SCRIPT_NAME"
SCRIPT_URL="https://raw.githubusercontent.com/$REPO/$BRANCH/$SCRIPT_NAME"

echo "======================================"
echo "   maintain-btrfs Installer"
echo "======================================"
echo

# Check dependencies
for cmd in curl sudo; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "❌ '$cmd' is required but not installed."
        exit 1
    fi
done

# Existing installation
if [[ -f "$INSTALL_PATH" ]]; then
    echo "⚠️  maintain-btrfs is already installed."

    read -rp "Overwrite the existing installation? [y/N]: " answer

    case "$answer" in
        [Yy]|[Yy][Ee][Ss]) ;;
        *)
            echo "Installation cancelled."
            exit 0
            ;;
    esac
fi

echo "📥 Downloading maintain-btrfs..."

sudo curl -fsSL "$SCRIPT_URL" -o "$INSTALL_PATH"

echo "🔧 Setting executable permissions..."
sudo chmod 755 "$INSTALL_PATH"

# Verify installation
if command -v maintain-btrfs >/dev/null 2>&1; then
    echo
    echo "✅ Installation successful!"
    echo
    echo "Installed to:"
    echo "  $INSTALL_PATH"
    echo
    echo "Run:"
    echo "  maintain-btrfs"
else
    echo "❌ Installation failed."
    exit 1
fi
