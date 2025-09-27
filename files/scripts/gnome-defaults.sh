#!/usr/bin/env bash

set -euo pipefail

mkdir -p /etc/gnome-initial-setup
cat <<'EOF' >/etc/gnome-initial-setup/vendor.conf
[pages]
# Never show "enable third party repository screen"
skip=software
EOF

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
