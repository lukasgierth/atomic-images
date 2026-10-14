# AGENTS.md

Project-specific rules for working in this repo. Loaded alongside the global `~/.pi/agent/AGENTS.md`; this file is the project-specific override layer.

## Project

Custom Fedora Atomic desktop images built with [BlueBuild](https://blue-build.org/):

- **sleepy-schaf** — GNOME, based on `ghcr.io/ublue-os/silverblue-main` (Fedora 44)
- **tipsy-tippete** — KDE Plasma, based on `ghcr.io/ublue-os/kinoite-main` (Fedora 44)

Images are rebuilt daily (06:00 UTC) by GitHub Actions and signed with cosign (Sigstore).

## Commands

- Lint/validate: `pre-commit run --all-files` (yamllint strict, check-yaml, end-of-file, trailing whitespace, conventional commits)
- Manual YAML lint: `yamllint -c .yamllint.yaml .`
- No test suite; recipes are exercised by the CI build workflow (`.github/workflows/build.yaml`).
- Dependencies/actions bump via Renovate (`.github/workflows/renovate.yaml`), not by hand.

## Layout

- `recipes/recipe-fedora-{silverblue,kinoite}.yaml` — the two image entry points (each pins `image-version:`).
- `recipes/shared-desktop.yaml` — module list common to both images.
- `recipes/modules/*.yaml` — reusable module fragments, included via `from-file:`.
- `files/` — file trees and scripts staged into the image; consumed by name from modules (see `files/README.md`).
- `iso-{silverblue,kinoite}.toml` — Anaconda installer config for the manual ISO workflow (`.github/workflows/build-iso.yaml`).
- `cosign.key` / `cosign.pub` — image signing keys; the private key is also the `SIGNING_SECRET` Actions secret. Both are gitignored except `cosign.pub`.

## Conventions

- Add desktop-agnostic functionality to `shared-desktop.yaml`; desktop-specific bits go into the individual recipes or their module fragments.
- Keep modules small and single-concern (e.g. `nix.yaml`, `fish.yaml`), and keep `files/` source dirs in sync with module `source:`/`scripts:` names.
- `image-version:` pins the Fedora release — bump it deliberately, never as part of dependency updates.
- Rebase instructions and the README verification section must reflect the actual registry/namespace (`ghcr.io/lukasgierth/...`) if either changes.
- The ISO workflow is manual-only (`workflow_dispatch`); do not schedule it.
- If signing key material changes, update `cosign.pub` and the `SIGNING_SECRET` secret together.
