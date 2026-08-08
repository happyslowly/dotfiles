#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v stow >/dev/null 2>&1; then
  echo "stow not installed" >&2
  exit 1
fi

packages=(zsh kitty nvim)

case "$OSTYPE" in
  darwin*) [ -d macos ] && packages+=(macos) ;;
  linux*)
    [ -d linux ] && packages+=(linux)
    mkdir -p "$HOME/.config/fcitx5/conf" "$HOME/.local/share/fcitx5/rime"
    ;;
esac

for pkg in "${packages[@]}"; do
  echo "stow: $pkg"
  stow --restow --target="$HOME" "$pkg"
done
