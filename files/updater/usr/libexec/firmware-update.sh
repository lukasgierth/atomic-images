#!/usr/bin/env bash
if gum confirm; then
	fwupdmgr refresh --force
	fwupdmgr update
fi
