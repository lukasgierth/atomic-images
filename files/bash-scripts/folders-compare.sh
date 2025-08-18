#!/usr/bin/env bash

command rsync -avun --delete ${1} ${2} | grep "^deleting "
command rsync -avun --delete ${2} ${1} | grep "^deleting "
