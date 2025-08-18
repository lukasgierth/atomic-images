#!/usr/bin/env bash

set -euo pipefail

# Hide applications which should not appear as gui applications to call
echo 'Hidden=true' >> /usr/share/applications/btop.desktop
echo 'Hidden=true' >> /usr/share/applications/gcdmaster.desktop
echo 'Hidden=true' >> /usr/share/applications/nvim.desktop
echo 'Hidden=true' >> /usr/share/applications/nvtop.desktop
