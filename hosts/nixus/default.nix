{
  pkgs,
  lib,
  self,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
  ];

  age.secrets.speakerctl-devices = {
    file = "${self}/secrets/speakerctl-devices.age";
    owner = "h0useofdupree";
    group = "users";
  };

  age.secrets.spotify-client-id = {
    file = "${self}/secrets/spotify-client-id.age";
    owner = "h0useofdupree";
    group = "users";
  };

  # age.secrets.weatherapi-key = {
  #   file = "${self}/secrets/weatherapi-key.age";
  #   owner = "h0useofdupree";
  #   group = "users";
  # };

  networking.hostName = "nixus";

  services = {
    fstrim.enable = true;

    # Disable wakeup from AMD USB-Controller
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1022" ATTR{device}=="0x43f7" ATTR{power/wakeup}="disabled"
      KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
    '';

    # xserver.displayManager.gdm.enable = true;
    # xserver.desktopManager.gnome.enable = true;
    xserver.xkb.layout = "us";
    xserver.xkb.variant = "altgr-intl";
  };

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
    initrd.kernelModules = ["amdgpu"];
    kernelModules = ["i2c-dev"];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # TODO: Clean this up!
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    ddcutil
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
    # texlive.combined.scheme-full
    zathura
  ];

  users.groups.i2c = {};
  users.users.h0useofdupree.extraGroups = ["i2c"];
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
