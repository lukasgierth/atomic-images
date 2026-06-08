#!/usr/bin/env bash

set -euo pipefail

UUID="karousel"
# renovate: datasource=github-releases depName=peterfajdiga/karousel extractVersion=true
VERSION=0.17
TMPDIR="/tmp/$UUID"
EXTDIR="/usr/share/kwin-wayland/scripts/$UUID"

rm -rf "$TMPDIR"
mkdir -p "$TMPDIR"
mkdir -p "$EXTDIR"
cd "$TMPDIR"

curl -L -o "source.tar.gz" "https://github.com/peterfajdiga/karousel/releases/download/v$VERSION/karousel_0_17.tar.gz"
tar xvf source.tar.gz
cd $UUID
cp -r * $EXTDIR/

rm -rf "$TMPDIR"
