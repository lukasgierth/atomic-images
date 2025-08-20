#!/usr/bin/env bash

set -euo pipefail

cat <<'EOF' >/etc/sudoers.d/journalctl
%wheel ALL=(ALL) NOPASSWD: /usr/bin/journalctl
EOF
