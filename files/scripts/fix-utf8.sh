#!/usr/bin/env bash

set -euo pipefail

# Workaround: Rename just's CN readme to README.zh-cn.md
# otherwise install with iso fails
mv '/usr/share/doc/just/README.中文.md' '/usr/share/doc/just/README.zh-cn.md'
