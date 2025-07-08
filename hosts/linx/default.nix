# TODO: Fix trackpad accel curve (maybe fixes DELL sluggish mouse bug) https://gist.github.com/fufexan/e6bcccb7787116b8f9c31160fc8bc543
{
  pkgs,
  self,
  lib,
  ...
}: {
  imports = [
    "${self}/hosts/linx/hardware-configuration.nix"
    ./hyprland.nix
  ];

  networking.hostName = "linx";

  services = {
    fstrim.enable = true;

    xserver.xkb.layout = "de";
    libinput.enable = true;
  };

  # Consider this!
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    git
    gnumake
    curl
    wget
    lazygit
    ripgrep
    go
    fzf
    bat
    eza
    nixd
    nitch
    tldr
    zoxide
    fd
    kitty
    kitty-themes
    os-prober
    fish
    wl-clipboard
    #texlive.combined.scheme-full
    zathura
  ];

  # Set user preferences for environment variables
  environment.variables = {
    LC_TIME = "de_DE.UTF-8"; # Time format
    LC_NUMERIC = "de_DE.UTF-8"; # Numeric format
    LC_MONETARY = "de_DE.UTF-8"; # Currency
    LC_MEASUREMENT = "de_DE.UTF-8"; # Units (e.g., metric)
    LANG = "en_US.UTF-8"; # Interface language
    NH_FLAKE = "/home/h0useofdupree/.dotfiles";
  };
}
