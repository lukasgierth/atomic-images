#!/usr/bin/env bash
if [ "${1}" = "-u" ]; then
	echo -e "--ignore-existing active"
	command rsync -Phrva --ignore-existing "${2}" "${3}" && command sync
fi
command rsync -Phrva "${1}" "${2}" && command sync
