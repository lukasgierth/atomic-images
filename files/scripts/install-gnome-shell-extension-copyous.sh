#!/usr/bin/env bash

set -euo pipefail

UUID="copyous@boerdereinar.dev"
# renovate: datasource=github-releases depName=boerdereinar/copyous extractVersion=true
VERSION=2.0.1
TMPDIR="/tmp/copyous-extension"
EXTDIR="/usr/share/gnome-shell/extensions/$UUID"

rm -rf "$TMPDIR"
mkdir -p "$TMPDIR"
cd "$TMPDIR"

mkdir -p "$EXTDIR"
curl -L -o "source.zip" "https://github.com/boerdereinar/copyous/releases/download/v${VERSION}/${UUID}.zip"
unzip -o "source.zip" -d "$EXTDIR"
glib-compile-schemas "$EXTDIR/schemas"

rm -rf "$TMPDIR"
