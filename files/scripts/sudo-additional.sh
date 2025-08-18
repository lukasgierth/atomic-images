#!/usr/bin/env bash

set -euo pipefail

cat <<'EOF' >/etc/sudoers.d/002-journalctl
%wheel ALL=(ALL) NOPASSWD: /usr/sbin/journalctl
EOF

cat <<'EOF' >/etc/sudoers.d/003-dmidecode
%wheel ALL=(ALL) NOPASSWD: /usr/sbin/dmidecode
EOF
