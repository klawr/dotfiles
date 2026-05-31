#!/usr/bin/env bash

pid=$(hyprctl activewindow -j | jq -r '.pid')

# basic sanity check
if [[ -z "$pid" || "$pid" == "null" || "$pid" == "0" ]]; then
  exec alacritty
fi

cwd="/proc/$pid/cwd"

# verify cwd is valid symlink
if [[ ! -e "$cwd" ]]; then
  exec alacritty
fi

target=$(readlink -f "$cwd" 2>/dev/null)

# fallback if resolution fails
if [[ -z "$target" || ! -d "$target" ]]; then
  target="$HOME"
fi

exec alacritty --working-directory "$target"
