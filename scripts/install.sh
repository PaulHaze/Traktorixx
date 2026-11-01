#!/bin/sh
# Install a copy because the macOS App Sandbox cannot follow our repo symlink.
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skins_dir="$HOME/Library/Containers/org.mixxx.mixxx/Data/Library/Application Support/Mixxx/skins"
destination="$skins_dir/Traktorixx"

mkdir -p "$skins_dir"
if [ -L "$destination" ]; then
    rm "$destination"
fi
mkdir -p "$destination"
cp -R "$repo_dir/skin/." "$destination/"
printf 'Installed Traktorixx in %s\n' "$destination"
