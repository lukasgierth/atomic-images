#!/usr/bin/env bash

for i in *.flac; do
	</dev/null ffmpeg -i "${i}" -c:a libopus -b:a 128000 -compression_level 10 -ac 2 "${i[@]/%flac/opus}"
done

rm *.flac
