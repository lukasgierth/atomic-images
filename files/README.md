# files/

Content staged into the image by BlueBuild modules. Each subdirectory is a separate concern, consumed by name from the recipe modules:

| Directory | Used by | Destination |
|---|---|---|
| `bash-profile/` | `modules/bash.yaml` | `/etc/profile.d` |
| `dnf/` | `type: dnf` repos (`modules/utils-desktop.yaml`) | repo file sources |
| `fish-functions/` | `modules/fish.yaml` | `/usr/share/fish/vendor_functions.d` |
| `gnome-backgrounds/` | Silverblue recipe | `/` (wallpapers + `gnome-background-properties`) |
| `gnome-utils/` | Silverblue recipe | `/` (`gnome-reorder-apps`, `gnome-reset-custom-keybindings`) |
| `gschema-overrides/` | `type: gschema-overrides` (Silverblue recipe) | compiled into the image |
| `nix/` | `modules/nix.yaml` | `/` (Nix overlay + daemon plumbing) |
| `rpm-ostreed/` | `modules/rpm-ostreed.yaml` | `/etc` |
| `scripts/` | `type: script` modules | shell scripts run at build time |
| `systemd/system/` | `type: systemd` modules | systemd unit files |
| `updater/` | `shared-desktop.yaml` | `/` (system/firmware updater applets) |
| `virtualization/` | `modules/virtualization.yaml` | `/` (libvirt config + `libvirt-setup-group`) |

Notes:

- `files/scripts/install-lix.sh` pins versions via `renovate:` markers consumed by the regex manager in `renovate.json` (pattern applies to `files/scripts/install.*`).
- Kernel/heuristic: files in `systemd/system/*.service` are enabled by name from the `type: systemd` modules (e.g. `nix-overlay.service`).
