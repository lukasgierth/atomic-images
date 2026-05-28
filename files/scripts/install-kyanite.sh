#!/usr/bin/env bash

set -euo pipefail

UUID="kyanite"
# renovate: datasource=github-releases depName=MurderFromMars/Kyanite extractVersion=true
VERSION=1.5
TMPDIR="/tmp/$UUID"
EXTDIR="/usr/share/kwin-wayland/scripts/$UUID"

rm -rf "$TMPDIR"
mkdir -p "$TMPDIR"
mkdir -p "$EXTDIR"
cd "$TMPDIR"

curl -L -o "source.tar.gz" "https://github.com/MurderFromMars/Kyanite/archive/refs/tags/V${VERSION}.tar.gz"
tar xvf source.tar.gz
cd Kyanite-$VERSION

cp metadata.json $EXTDIR/
cp -r contents $EXTDIR/

rm -rf "$TMPDIR"
