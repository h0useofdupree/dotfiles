# NixOS Multi-Host Configuration

## Build

![GitHub Actions workflow status](https://img.shields.io/github/actions/workflow/status/h0useofdupree/dotfiles/.github%2Fworkflows%2Fnix-flake-check.yml?style=for-the-badge)
![GitHub last commit](https://img.shields.io/github/last-commit/h0useofdupree/dotfiles?style=for-the-badge)
![GitHub commit activity](https://img.shields.io/github/commit-activity/w/h0useofdupree/dotfiles?style=for-the-badge)

![GitHub commits since latest release](https://img.shields.io/github/commits-since/h0useofdupree/dotfiles/latest?style=for-the-badge)
![GitHub repo size](https://img.shields.io/github/repo-size/h0useofdupree/dotfiles?style=for-the-badge)
![GitHub license](https://img.shields.io/github/license/h0useofdupree/dotfiles?style=for-the-badge)

<!--toc:start-->

- [NixOS Multi-Host Configuration](#nixos-multi-host-configuration)
  - [Build](#build)
  - [Overview](#overview)
  - [Repository layout](#repository-layout)
  - [Hosts](#hosts)
  - [Nix](#nix)
  - [Custom modules](#custom-modules)
  - [Custom packages](#custom-packages)
  - [Desktop usage](#desktop-usage)

<!--toc:end-->

## Overview

This repository contains my personal flake for managing several machines with
NixOS and Home-Manager. It is heavily inspired by
[Fufexan's](https://github.com/fufexan/fufexan) work and acts as my single
source of truth for both system and user configuration.

The code is tailored for my own use, but it can also serve as an example of how
to structure a multi‑host setup. Feel free to explore and adapt pieces that
interest you.

I treat this repo as a training ground for version-control and coding
practises - don't take stuff like releases seriously. I am just trying to learn,
**like you**.

## Repository layout

- **hosts** – NixOS configuration for each machine.
- **home** – Home‑Manager modules and profiles.
- **modules** – extra Home‑Manager modules (dynamic wallpaper, speakerctl,
  theme).
- **pkgs** – custom packages (scripts, helpers and small utilities).
- **system** – common NixOS modules shared by all hosts.
- **lib** – helper functions and wallpaper assets used throughout the flake.

## Hosts

The flake currently builds two machines:

- **nixus** – an AMD desktop tower.
- **linx** – an Intel/NVIDIA laptop.

Each host imports the shared modules from `system/` and also pulls in its
corresponding Home‑Manager profile from `home/profiles`.

## Nix

- Home‑Manager is used as a NixOS module.
- [`flake-parts`](https://github.com/hercules-ci/flake-parts) is used to
  organise the flake.
- A development shell is provided via `nix develop` which also installs
  pre‑commit hooks.

## Custom modules

Several small modules live under `modules/`:

- **dynamicWallpaper** – systemd timer that rotates wallpapers based on the time
  of day.
- **speakerctl** – helper for controlling Tuya smart sockets to toggle my
  speakers.
- **theme** – stores a simple theme name and wallpaper path which other modules
  can query.

## Custom packages

The `pkgs/` directory contains small utilities packaged with Nix. Notable ones
include:

- **bibata-hyprcursor** – Bibata cursor theme packaged for `hyprcursor`.
  (credits to mihai)
- **dynamic-wallpaper** – script used by the dynamic wallpaper module.
- **speakerctl** – Python script to control smart plugs.
- **wl-ocr** – screenshot an area and OCR it using Tesseract.
- **repl** – convenience wrapper to launch a flake-aware `nix repl`.

## Desktop usage

I daily drive the [Hyprland](https://github.com/hyprwm/Hyprland) compositor
along with several extras including

- [Quickshell](https://quickshell.outfoxxed.me) using the
  - [Caelestia](https://github.com/caelestia-dots/shell) configuration, of which
    I am currently using my own fork.

Browser wise I use `zen-browser` and `qutebrowser`. My main shell is `fish` but
`zsh` is also lightly configured.
