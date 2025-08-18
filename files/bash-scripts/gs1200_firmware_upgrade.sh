#!/usr/bin/env bash
#TODO: format
set -e

if [ $# -lt 1 ]; then
	echo "Usage: GS1200_firmware_upgrade.sh IP"
	exit 1
fi

U_IP=$1
rm GS1200-*.bin 2>/dev/null
unzip -u GS1200-*.zip
U_FIRM=$(ls GS1200-*.bin)
curl -F "firmware=<$U_FIRM" -o /dev/null "http://$U_IP/httpupg.cgi?cmd=fw_upgrade"
