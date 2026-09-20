#!/bin/bash
set -euo pipefail
source_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
destination="$HOME/.config/omarchy/themes/midgar-mako"
backup="$HOME/.local/state/omarchy/backups/midgar-mako-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup"
for relative in themes/midgar-mako screensaver branding/screensaver.txt hooks/theme-set.d/40-midgar-branding; do
  file="$HOME/.config/omarchy/$relative"
  if [[ -e $file || -L $file ]]; then
    mkdir -p "$backup/$(dirname "$relative")"
    cp -a "$file" "$backup/$relative"
  fi
done
mkdir -p "$destination" "$HOME/.config/omarchy/screensaver"
cp -a "$source_dir/." "$destination/"
cp "$source_dir/screensaver/launch" "$HOME/.config/omarchy/screensaver/launch"
cp "$source_dir/screensaver/foot.ini" "$HOME/.config/omarchy/screensaver/foot.ini"
omarchy hook install theme-set "$source_dir/integration/40-midgar-branding"
omarchy theme set midgar-mako
printf 'Backup: %s\n' "$backup"
