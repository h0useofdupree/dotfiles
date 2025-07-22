# NixOS Multi-Host Configuration

## Build

![Build status](https://github.com/h0useofdupree/dotfiles/actions/workflows/nix-flake-check.yml/badge.svg)

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
  - [Getting started](#getting-started)

<!--toc:end-->

## Overview

This repository contains my personal flake for managing several machines with
NixOS and Home-Manager. It is heavily inspired by
[Fufexan's](https://github.com/fufexan/fufexan) work and acts as my single
source of truth for both system and user configuration.

The code is tailored for my own use, but it can also serve as an example of how
to structure a multi‑host setup. Feel free to explore and adapt pieces that
interest you.

## Repository layout

- **hosts** – NixOS configuration for each machine.
- **home** – Home‑Manager modules and profiles.
- **modules** – extra Home‑Manager modules (dynamic wallpaper, speakerctl,
  theme).
- **pkgs** – custom packages (scripts, helpers and small utilities).
- **system** – common NixOS modules shared by all hosts.
- **lib** – helper functions used throughout the flake.

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
- **dynamic-wallpaper** – script used by the dynamic wallpaper module.
- **speakerctl** – Python script to control smart plugs.
- **wl-ocr** – screenshot an area and OCR it using Tesseract.
- **repl** – convenience wrapper to launch a flake-aware `nix repl`.

## Desktop usage

I daily drive the [Hyprland](https://github.com/hyprwm/Hyprland) compositor
along with several extras:

<!-- TODO: add Quickshell (thanks to Caelestia creators!!)-->

Browser wise I use `zen-browser` and `qutebrowser`. My main shell is `fish` but
`zsh` is also configured.

## Getting started

Clone the repository and run `nix develop` to enter the dev environment. From
there you can build any host with
`nix build .#nixosConfigurations.<hostname>.config.system.build.toplevel` or
switch to it with `sudo nixos-rebuild switch --flake .#<hostname>`.
