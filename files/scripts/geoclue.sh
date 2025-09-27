#!/usr/bin/env bash

set -euo pipefail

mkdir -p /etc/geoclue/conf.d
cat <<'EOF' >/etc/geoclue/conf.d/99-beacondb.conf
[wifi]
enable=true
url=https://api.beacondb.net/v1/geolocate
EOF
