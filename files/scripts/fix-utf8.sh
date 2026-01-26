#!/usr/bin/env bash

set -euo pipefail

# Workaround: Rename just's CN readme to README.zh-cn.md
# otherwise install with iso fails
mv -f '/usr/share/doc/just/README.中文.md' '/usr/share/doc/just/README.zh-cn.md'
rm -f '/usr/share/doc/niri/wiki/Layer‐Shell-Components.md'
