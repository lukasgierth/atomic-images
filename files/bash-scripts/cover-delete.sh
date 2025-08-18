#!/usr/bin/env bash

TMP_DIR="tmp"

if [[ $1 = "flac" || $1 = "mp3" || $1 = "ogg" || $1 = "opus" ]]; then
	mkdir "${TMP_DIR}"
	for i in *."${1}"; do
		</dev/null command ffmpeg -i "${i}" -c:a copy -vn "${TMP_DIR}/${i[@]/%$1/$1}"
	done
	rm -f *."${1}"
	mv -f "${TMP_DIR}"/* .
	rmdir "${TMP_DIR}"
	echo "DONE"
else
	echo "Format not supported"
fi
