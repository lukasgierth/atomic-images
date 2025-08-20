#!/usr/bin/env bash

set -euo pipefail

# Bash Shell
cat <<'EOF' >/etc/profile.d/prefer-bootc-over-rpm-ostree.sh
# Prefer 'bootc update/upgrade' & 'bootc switch' over rpm-ostree's equivalent functionality
rpm-ostree() {
  if [[ ${#} -eq 0 ]]; then
    /usr/bin/rpm-ostree
  elif [[ -n "$(awk '/(^|\s)('update'|'upgrade')($|\s)/' <<< "${@}")" ]]; then
    echo "ERROR: Don't use 'rpm-ostree update/upgrade', use 'sudo bootc update/upgrade' instead."
    echo "       Some functionality like kargs.d is only available when using bootc, hence why we slowly deprecate rpm-ostree."
  elif [[ -n "$(awk '/(^|\s)('rebase')($|\s)/' <<< "${@}")" ]]; then
    echo "ERROR: Don't use 'rpm-ostree rebase', use 'sudo bootc switch' instead."
    echo "       Some functionality like kargs.d is only available when using bootc, hence why we slowly deprecate rpm-ostree."
  else
    /usr/bin/rpm-ostree "${@}"
  fi
}

export -f rpm-ostree
EOF

# Fish Shell
cat <<'EOF' >/usr/share/fish/vendor_functions.d/rpm-ostree.fish
# Prefer 'bootc update/upgrade' & 'bootc switch' over rpm-ostree's equivalent functionality
function rpm-ostree
    if test (count $argv) -eq 0
        /usr/bin/rpm-ostree
    else if echo $argv | string match -rq '(^|\s)(update|upgrade)($|\s)'
        echo "ERROR: Don't use 'rpm-ostree update/upgrade', use 'sudo bootc update/upgrade' instead."
        echo "       Some functionality like kargs.d is only available when using bootc, hence why we slowly deprecatec rpm-ostree."
    else if echo $argv | string match -rq '(^|\s)rebase($|\s)'
        echo "ERROR: Don't use 'rpm-ostree rebase', use 'sudo bootc switch' instead."
        echo "       Some functionality like kargs.d is only available when using bootc, hence why we slowly deprecate rpm-ostree."
    else
        /usr/bin/rpm-ostree $argv
    end
end
EOF

# Patch bootc to not need sudo for updating

# Bash Shell
cat <<'EOF' >/etc/profile.d/bootc.sh
if [ "$EUID" -ne 0 ]; then
    bootc() {
        # Check if the command is already running with sudo
        if [ "$EUID" -eq 0 ]; then
            /usr/bin/bootc "$@"
        else
            sudo /usr/bin/bootc "$@"
        fi
    }
fi
EOF

# Fish Shell
cat <<'EOF' >/usr/share/fish/vendor_conf.d/bootc.fish
if test (id -u) -ne 0
    function bootc
        if test (id -u) -eq 0
            /usr/bin/bootc $argv
        else
            sudo /usr/bin/bootc $argv
        end
    end
end
EOF

cat <<'EOF' >/etc/sudoers.d/bootc
%wheel ALL=(ALL) NOPASSWD: /usr/bin/bootc update, /usr/bin/bootc upgrade, /usr/bin/bootc status, /usr/bin/bootc status --booted
EOF
