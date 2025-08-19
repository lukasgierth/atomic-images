# disable greeting
set -g fish_greeting ""

# change some default variables
set -g EDITOR nvim
set -g SUDO_EDITOR nvim
set -g MANPAGER less

# vi mode as default, with some small changes
fish_vi_key_bindings
set -g fish_vi_force_cursor
set -g fish_cursor_default block
set -g fish_cursor_insert line blink
set -g fish_cursor_replace_one underscore
