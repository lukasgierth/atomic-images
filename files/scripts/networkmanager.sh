#!/usr/bin/env bash

set -euo pipefail

# overwrites the default connectivity checker if run
mkdir -p /usr/lib/NetworkManager/conf.d
cat <<'EOF' >/usr/lib/NetworkManager/conf.d/20-connectivity-fedora.conf
[connectivity]
enable=true
uri=http://fedoraproject.org/static/hotspot.txt
response=OK
interval=300
EOF
