#!/usr/bin/env bash

set -euo pipefail

# Hide applications which should not appear as gui applications to call
echo 'Hidden=true' >>/usr/share/applications/aerc.desktop
echo 'Hidden=true' >>/usr/share/applications/btop.desktop
echo 'Hidden=true' >>/usr/share/applications/gcdmaster.desktop
echo 'Hidden=true' >>/usr/share/applications/nvim.desktop
echo 'Hidden=true' >>/usr/share/applications/nvtop.desktop
echo 'Hidden=true' >>/usr/share/applications/btrfs-assistant.desktop
