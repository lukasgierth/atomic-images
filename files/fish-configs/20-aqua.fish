set -g AQUA_DISABLE_LAZY_INSTALL true
set -g AQUA_GLOBAL_CONFIG $HOME/.config/aqua/aqua.yaml
set -g AQUA_ROOT_DIR $HOME/.local/share/aqua
if test -d "$AQUA_ROOT_DIR/bin"
    fish_add_path "$AQUA_ROOT_DIR/bin"
end
