#!/usr/bin/env bash

set -euo pipefail

# Bash Shell
cat <<'EOF' >/usr/lib/systemd/system/setup-docker-group.service
[Unit]
Description=Set up docker group and add all users to it
ConditionPathExists=!/etc/setup-docker-group
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/bin/bash -c "getent group docker &> /dev/null || groupadd -r docker; for user in $(getent passwd | grep 'home' | awk -F: '{print $1}'); do usermod -aG docker $user; done"
ExecStart=/usr/bin/touch /etc/setup-docker-group
ExecStart=/usr/bin/systemctl restart docker.service

[Install]
WantedBy=multi-user.target
EOF
