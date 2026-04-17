# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Linux dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). The repo lives at `~/.dotfiles` and symlinks config files into `$HOME`.

## Key Scripts

- `bash bootstrap.sh` — full setup: stows dotfiles, installs Firefox policies & Arkenfox directives, installs VSCodium extensions
- `bash update.sh` — refreshes `non-home/codium-extensions` from the currently installed Codium extensions

## Repository Layout

- **Stowable files** (everything not in `.stow-local-ignore`) — mirrored into `$HOME` as symlinks by `stow --no-folding --restow --adopt`
- **`non-home/`** — files deployed outside `$HOME` or used by bootstrap without being stowed: `firefox-policies.json` (→ `/etc/firefox/policies/`), `firefox-user-overrides.js` (→ Firefox profile), `codium-extensions` (extension list)
- **`non-automated/`** — configs not yet bootstrapped (e.g., `Redirector.json` for the Firefox Redirector extension)

## How Stowing Works

`bootstrap.sh` uses `--adopt` to absorb any existing files, then immediately runs `git restore` on all stowable paths to reset them to the repo's state. **Uncommitted changes to stowable files will cause the script to abort** — commit, revert, or stash them first.

`.stow-local-ignore` excludes `Readme.md`, `bootstrap.sh`, `update.sh`, `.stow-local-ignore`, and the `non-automated`/`non-home` directories from stowing.

## Prerequisites (before running bootstrap)

`pass` must be initialised and contain:
- `Dotfiles/email`
- `Dotfiles/MAC/headset`
- `Dotfiles/MAC/speaker`

These are read at login by `.bash_profile` and exported as `EMAIL`, `HEADSET`, `SPEAKER`.
