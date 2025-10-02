#!/usr/bin/env bash

set -euo pipefail

mkdir -p /etc/gnome-initial-setup
cat <<'EOF' >/etc/gnome-initial-setup/vendor.conf
[pages]
# Never show "enable third party repository screen"
skip=software
EOF

mkdir -p /etc/dconf/db/distro.d
cat <<'EOF' >/etc/dconf/db/distro.d/01-custom-keybindings
[org/gnome/settings-daemon/plugins/media-keys]
# The entire array must be defined on a single line.
custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3']

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0]
name='Open Wezterm'
command='flatpak run org.wezfurlong.wezterm'
binding='<Super><Shift>t'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1]
name='Open Default Terminal'
command='ptyxis'
binding='<Super>t'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2]
name='Open Firefox'
command='flatpak run org.mozilla.firefox'
binding='<Super>b'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3]
name='Open Files'
command='nautilus'
binding='<Super>f'
EOF
echo "Update dconf db now after changes!" && dconf update

# cat <<'EOF' >/usr/share/glib-2.0/schemas/zzo-sleepy-schaf-modifications.gschema.override
# [org.gnome.desktop.background]
# # TODO:
# picture-uri='file:///usr/share/backgrounds/bluefin/12-bluefin.xml'
# picture-uri-dark='file:///usr/share/backgrounds/bluefin/12-bluefin.xml'
# picture-options='zoom'
# primary-color='000000'
# secondary-color='FFFFFF'
#
# [org.gnome.desktop.interface]
# enable-hot-corners=false
# clock-show-weekday=false
# font-antialiasing="rgba"
# font-name="Adwaita Sans 11"
# document-font-name="Adwaita Sans 11"
# monospace-font-name="Adwaita Mono 11"
#
# # [org.gnome.desktop.wm.preferences]
# # button-layout=":minimize,maximize,close"
# # num-workspaces=4
# # titlebar-font="Adwaita Sans Bold 12 @wght=700"
#
# # [org.gnome.desktop.peripherals.keyboard]
# # numlock-state=true
#
# [org.gnome.desktop.search-providers]
# enabled=['io.github.kolunmi.Bazaar.desktop']
#
# [org.gnome.desktop.sound]
# allow-volume-above-100-percent=true
# theme-name="freedesktop"
#
# [org.gtk.Settings.FileChooser]
# sort-directories-first=true
#
# [org.gtk.gtk4.Settings.FileChooser]
# sort-directories-first=true
#
# [org.gnome.mutter]
# center-new-windows=true
# EOF
