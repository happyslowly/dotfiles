#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v stow >/dev/null 2>&1; then
  echo "stow not installed" >&2
  exit 1
fi

packages=(zsh kitty nvim)

for pkg in "${packages[@]}"; do
  echo "stow: $pkg"
  stow --restow --target="$HOME" "$pkg"
done
