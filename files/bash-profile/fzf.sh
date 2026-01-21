# only needed in interactive shell
if [[ $- == *i* ]]; then
	# activate fzf functions
	if command -v fzf &>/dev/null; then
		eval "$(fzf --bash)"
	fi
fi
