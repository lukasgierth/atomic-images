export AQUA_DISABLE_LAZY_INSTALL=true
export AQUA_GLOBAL_CONFIG=$HOME/.config/aqua/aqua.yaml
export AQUA_ROOT_DIR=$HOME/.local/share/aqua

if [[ -d "$AQUA_ROOT_DIR/bin" ]]; then
	export PATH="$AQUA_ROOT_DIR/bin:$PATH"
fi
