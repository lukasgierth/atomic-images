#!/usr/bin/env bash

set -euo pipefail

# Patch docker to not need sudo

# Bash Shell
cat <<'EOF' >/etc/profile.d/docker.sh
if [ "$EUID" -ne 0 ]; then
    docker() {
        # Check if the command is already running with sudo
        if [ "$EUID" -eq 0 ]; then
            /usr/bin/docker "$@"
        else
            sudo /usr/bin/docker "$@"
        fi
    }
fi
EOF

# Fish Shell
cat <<'EOF' >/usr/share/fish/vendor_conf.d/docker.fish
if test (id -u) -ne 0
    function docker
        if test (id -u) -eq 0
            /usr/bin/docker $argv
        else
            sudo /usr/bin/docker $argv
        end
    end
end
EOF

cat <<'EOF' >/etc/sudoers.d/docker
%wheel ALL=(ALL) NOPASSWD: /usr/bin/docker
EOF
