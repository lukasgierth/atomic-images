#!/usr/bin/env bash

set -euo pipefail

cat <<'EOF' >/usr/share/fish/vendor_functions.d/sudo.fish
function sudo --description 'Run sudo while preserving env/PATH'
	command sudo --preserve-env=PATH env $argv
end
EOF
