#!/usr/bin/env bash

magick $1 -colorspace YUV -resize ${2}x${2} -sampling-factor 4:2:0 neu.jpg
