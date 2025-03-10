{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixus";

  services = {
    fstrim.enable = true;

    # Disable wakeup from AMD USB-Controller
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1022" ATTR{device}=="0x43f7" ATTR{power/wakeup}="disabled"
    '';

    # xserver.enable = true;
    # xserver.displayManager.gdm.enable = true;
    # xserver.desktopManager.gnome.enable = true;
    xserver.xkb.layout = "us";
    xserver.xkb.variant = "altgr-intl";
  };

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
    initrd.kernelModules = ["amdgpu"];
  };

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
    qutebrowser
    os-prober
    fish
    wl-clipboard
    texlive.combined.scheme-full
    zathura
  ];

  # Set user preferences for environment variables
  environment.variables = {
    LC_TIME = "de_DE.UTF-8"; # Time format
    LC_NUMERIC = "de_DE.UTF-8"; # Numeric format
    LC_MONETARY = "de_DE.UTF-8"; # Currency
    LC_MEASUREMENT = "de_DE.UTF-8"; # Units (e.g., metric)
    LANG = "en_US.UTF-8"; # Interface language
    FLAKE = "/home/h0useofdupree/.dotfiles";
  };
}
