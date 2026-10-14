# Recipes

BlueBuild recipes that define the two images:

- `recipe-fedora-silverblue.yaml` — **sleepy-schaf** (GNOME, based on Silverblue)
- `recipe-fedora-kinoite.yaml` — **tipsy-tippete** (KDE Plasma, based on Kinoite)

Each recipe refreshes the ublue base image and layers on modules: package changes (dnf), Flatpaks, file trees, scripts, systemd units, kernel args, `os-release` metadata, initramfs regeneration, and image signing.

- `shared-desktop.yaml` — modules common to both images (utilities, Flatpaks, shell config, kernel args, Nix).
- `modules/*.yaml` — reusable, composable module fragments included via `from-file:`.

## Adding or changing things

1. Put new functionality in a module, e.g. new `modules/foo.yaml`.
2. Reference it from both recipes directly, or add it to `shared-desktop.yaml` if it should apply to both images.
3. Scripts and file trees that modules consume live under [`files/`](../files/); keep the module's `source` / `scripts` names in sync with the directories there.
4. Bump `image-version:` deliberately — it pins the Fedora release, so an accidental bump is a major-version change.
5. Lint with `pre-commit run --all-files`; the recipes are validated by the build workflow in CI.
