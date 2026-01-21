# only needed in interactive shell
if [[ $- == *i* ]]; then
	# activate zoxide functions
	if command -v zoxide &>/dev/null; then
		eval "$(zoxide init bash)"
	fi
fi
