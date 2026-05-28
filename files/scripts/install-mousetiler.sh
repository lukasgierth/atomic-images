#!/usr/bin/env bash

set -euo pipefail

UUID="mousetiler"
# renovate: datasource=github-releases depName=rxappdev/MouseTiler extractVersion=true
VERSION=6.3.2
TMPDIR="/tmp/$UUID"
EXTDIR="/usr/share/kwin-wayland/scripts/$UUID"

rm -rf "$TMPDIR"
mkdir -p "$TMPDIR"
mkdir -p "$EXTDIR"
cd "$TMPDIR"

curl -L -o "source.tar.gz" "https://github.com/rxappdev/MouseTiler/archive/refs/tags/v${VERSION}.tar.gz"
tar xvf source.tar.gz
cd MouseTiler-$VERSION

cp src/metadata.json $EXTDIR/
cp -r src/contents $EXTDIR/

rm -rf "$TMPDIR"
