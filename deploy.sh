#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -A CONFIGS=(
    [nvim]="$HOME/.config/nvim"
    [tmux]="$HOME/.config/tmux"
)

for name in "${!CONFIGS[@]}"; do
    src="$REPO_DIR/$name"
    dst="${CONFIGS[$name]}"
    echo "$src -> $dst"
    rm -rf "$dst"
    cp -r "$src" "$dst"
done

chmod +x "$HOME/.config/tmux/rename_format.sh"
