#!/usr/bin/env bash

set -euo pipefail

# Bash Shell
cat <<'EOF' >/usr/lib/systemd/system/signed-autorebase.service
[Unit]
Description=Autorebase to signed OCI and reboot
ConditionPathExists=!/etc/autorebase-signed
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
StandardOutput=journal+console
ExecStart=/usr/bin/rpm-ostree rebase --bypass-driver ostree-image-signed:docker://ghcr.io/lukasgierth/sleepy-schaf:latest
ExecStart=/usr/bin/touch /etc/autorebase-signed
ExecStart=/usr/bin/systemctl disable signed-autorebase.service

[Install]
WantedBy=multi-user.target
EOF
