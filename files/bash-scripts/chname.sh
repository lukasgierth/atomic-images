#!/usr/bin/env bash
for x in *; do
	mv -- "$x" "${x//"$1"/"$2"}"
done
