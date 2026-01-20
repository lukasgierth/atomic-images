if command -v krew &>/dev/null; then
	if [[ ! -d "$HOME/.krew/bin" ]]; then
		mkdir -p "$HOME/.krew/bin"
	fi
	export PATH="$HOME/.krew/bin:$PATH"
fi
