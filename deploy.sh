#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -A CONFIGS=(
    [nvim]="$HOME/.config/nvim"
    [tmux]="$HOME/.config/tmux"
    [graft]="$HOME/.config/graft"
)

git -C "$REPO_DIR" submodule update --init --recursive

for name in "${!CONFIGS[@]}"; do
    src="$REPO_DIR/$name"
    dst="${CONFIGS[$name]}"
    if [[ ! -d "$src" ]]; then
        echo "skipping $name (not in repo)"
        continue
    fi
    echo "$src -> $dst"
    rm -rf "$dst"
    cp -r "$src" "$dst"
done

chmod +x "$HOME/.config/tmux/rename_format.sh"
