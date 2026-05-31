#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -A CONFIGS=(
    [nvim]="$HOME/.config/nvim"
    [tmux]="$HOME/.config/tmux"
    [alacritty]="$HOME/.config/alacritty"
    [ashell]="$HOME/.config/ashell"
    [graft]="$HOME/.config/graft"
    [hypr]="$HOME/.config/hypr"
    [wofi]="$HOME/.config/wofi"
)

for name in "${!CONFIGS[@]}"; do
    src="${CONFIGS[$name]}"
    dst="$REPO_DIR/$name"
    if [[ ! -d "$src" ]]; then
        echo "skipping $name (not found at $src)"
        continue
    fi
    echo "$src -> $dst"
    rm -rf "$dst"
    cp -r "$src" "$dst"

    # Auto-register any nested git repos as submodules
    while IFS= read -r -d '' gitdir; do
        nested="${gitdir%/.git}"
        rel="${nested#$REPO_DIR/}"
        if ! git -C "$REPO_DIR" config --file .gitmodules "submodule.$rel.url" &>/dev/null; then
            url=$(git -C "$nested" remote get-url origin 2>/dev/null || true)
            if [[ -n "$url" ]]; then
                echo "  registering submodule: $rel -> $url"
                rm -rf "$nested"
                git -C "$REPO_DIR" submodule add "$url" "$rel"
            else
                echo "  warning: $rel is a git repo with no remote, skipping submodule registration"
            fi
        fi
    done < <(find "$dst" -mindepth 2 -name ".git" -print0)
done
