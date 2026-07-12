# maintain-btrfs

A simple Bash utility for Arch Linux that automates common Btrfs and system maintenance tasks.

## Features

- 📸 Cleans Snapper or Timeshift snapshots
- 📦 Cleans the Pacman package cache
- 🗑️ Removes orphan packages
- 🧹 Removes broken Pacman download cache directories
- 🧽 Clears user and system cache
- ⚖️ Runs a light Btrfs balance
- 🧪 Starts a Btrfs scrub

## Requirements

- Arch Linux or an Arch-based distribution
- Bash
- `sudo`

Optional tools:
- `snapper`
- `timeshift`
- `pacman-contrib` (for `paccache`)
- `btrfs-progs`

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/noah8282/maintain-btrfs/main/install.sh | bash
```

## Usage

After installation, simply run:

```bash
maintain-btrfs
```

## Manual Installation

```bash
git clone https://github.com/noah8282/maintain-btrfs.git
cd maintain-btrfs
chmod +x install.sh
./install.sh
```

## What It Does

The script performs the following maintenance tasks:

1. Cleans Snapper or Timeshift snapshots (if installed)
2. Removes broken Pacman download cache
3. Cleans the Pacman package cache
4. Removes orphan packages
5. Clears `~/.cache`
6. Clears `/var/tmp`
7. Runs a light Btrfs balance
8. Starts a Btrfs scrub

## Uninstall
```bash
sudo rm -f /usr/local/bin/maintain-btrfs
```
## Disclaimer

This script modifies your system and requires `sudo` privileges. Review the source code before running it and use it at your own risk.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
