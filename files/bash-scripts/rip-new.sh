#!/usr/bin/env bash

pushd ~/Rip
whipper drive analyze
whipper offset find
whipper cd rip --compression-level 8
popd