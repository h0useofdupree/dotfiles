# NixOS Multi-Host Configuration

## Build

![Build status](https://github.com/h0useofdupree/dotfiles/actions/workflows/nix-flake-check.yml/badge.svg)

<!--toc:start-->

- [NixOS Multi-Host Configuration](#nixos-multi-host-configuration)
  - [Build](#build)
  - [Description](#description)
  - [Hosts](#hosts)
  - [Nix](#nix)
  - [Desktop Usage](#desktop-usage)
    - [Window Manager etc](#window-manager-etc)
    - [Custom scripts](#custom-scripts)
    - [Editors](#editors)
    - [Browsers](#browsers)
    - [Shells](#shells)

<!--toc:end-->

## Description

My multi-host dotfiles, inspired by
[Fufexan's](https://github.com/fufexan/fufexan) work. This is **not** meant to
be used by anyone else but me, although I can't stop you. If so, figure it out
like me.

## Hosts

- nixus (all AMD Tower)
- linx (Intel/Nvidia Laptop)

## Nix

- Home-Manager as NixOS module
- flake-parts

## Desktop Usage

### Window Manager etc

- Hyprland (and Eco-System)
- HyprPanel (Astal/AGS)

### Custom scripts

- Custom Dynamic Wallpaper module/pkg with options
- speakerctl (locally control tuya smart sockets which control my speakers and
  soon other devices)

### Editors

- nvf (nvim for flakes)
- neovide as front-end

### Browsers

- zen-browser
- qutebrowser

### Shells

- fish (main)
- zsh (sec)
