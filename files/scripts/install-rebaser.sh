#!/usr/bin/env bash

set -euo pipefail

# Bash Shell
cat <<'EOF' >/usr/bin/rebase-to-signed-image.sh
#!/usr/bin/env bash

set -euo pipefail

CURRENT_REF=$(rpm-ostree status --json | jq -r '.deployments[0]."container-image-reference"')
if [[ -z "$CURRENT_REF" ]]; then
	echo "Error: Could not retrieve container-image-reference from rpm-ostree status."
	exit 1
fi

# Extract the prefix before the first colon
TEST_SIGNED=${CURRENT_REF%%:*}

# Extract the part starting with "ghcr"
IMAGE=$(echo "$CURRENT_REF" | grep -o 'ghcr.*' || true)

if [[ "${TEST_SIGNED}" == "ostree-image-signed" ]]; then
	echo "Current image is ${TEST_SIGNED} already, exit"
else
	if [[ -n "${IMAGE}" ]]; then
		echo "Current image is ${TEST_SIGNED}, rebasing to signed image ostree-image-signed:docker://${IMAGE}"
		if command rpm-ostree rebase "ostree-image-signed:docker://${IMAGE}"; then
			echo "Rebase successful."
		else
			echo "Rebase failed."
			exit 1
		fi
	else
		echo "Warning: Could not identify ghcr portion of the image reference."
		exit 1
	fi
fi

echo "Disable service now"
systemctl disable rebase-to-signed-image.service
EOF

chmod 0755 /usr/bin/rebase-to-signed-image.sh
