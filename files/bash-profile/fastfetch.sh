# overwrite fastfetch default
if command -v fastfetch &>/dev/null; then
	alias fastfetch="command fastfetch -c /usr/share/fastfetch/presets/examples/27.jsonc"
fi
