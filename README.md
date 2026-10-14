# Sleepy Schaf & Tipsy Tippete

[![build status](https://github.com/lukasgierth/atomic-images/actions/workflows/build.yaml/badge.svg)](https://github.com/lukasgierth/atomic-images/actions/workflows/build.yaml)

Custom [Fedora Atomic](https://fedoraproject.org/atomic-desktop/) desktop images built with [BlueBuild](https://blue-build.org/):

| Image | Desktop | Base image |
|---|---|---|
| `sleepy-schaf` | GNOME | `ghcr.io/ublue-os/silverblue-main` |
| `tipsy-tippete` | KDE Plasma | `ghcr.io/ublue-os/kinoite-main` |

- Recipes live in [`recipes/`](recipes/); each pins the Fedora version via `image-version:`.
- Images are rebuilt daily at 06:00 UTC (`.github/workflows/build.yaml`) and signed with [cosign](https://github.com/sigstore/cosign).

## Installation

To rebase an existing atomic Fedora installation to the latest build:

1. First rebase to the unsigned image, to get the proper signing keys and policies installed:
   ```
   rpm-ostree rebase ostree-unverified-registry:ghcr.io/lukasgierth/sleepy-schaf:latest
   ```
2. Reboot to complete the rebase:
   ```
   systemctl reboot
   ```
3. Then rebase to the signed image:
   ```
   rpm-ostree rebase ostree-image-signed:docker://ghcr.io/lukasgierth/sleepy-schaf:latest
   ```
4. Reboot again to complete the installation:
   ```
   systemctl reboot
   ```

Replace `sleepy-schaf` with `tipsy-tippete` for the KDE image. The `latest` tag always points to the newest build for the Fedora version pinned in the recipe, so you won't get accidentally updated to the next major version.

## ISO installers

ISOs are built manually on demand via the [Build ISO installer workflow](https://github.com/lukasgierth/atomic-images/actions/workflows/build-iso.yaml) (`workflow_dispatch` only, no nightlies) — the `iso-silverblue.toml` / `iso-kinoite.toml` configs tune the Anaconda installer.

- Trigger the workflow, then download the installer ISO artifact from the finished run (kept for 90 days).
- Verify the checksum shipped alongside the artifact and write the ISO to a USB stick, e.g.:
  ```
  dd if=sleepy-schaf_<date>.iso of=/dev/sdX bs=4M status=progress
  ```

## Verification

The images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). Verify the signature by downloading the `cosign.pub` file from this repo and running:

```bash
cosign verify --key cosign.pub ghcr.io/lukasgierth/sleepy-schaf
```
