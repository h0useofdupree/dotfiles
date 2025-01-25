{
  pkgs,
  self,
  ...
}: {
  imports = [
    "${self}/hosts/linx/hardware-configuration.nix"
  ];

  networking.hostName = "linx";

  services = {
    fstrim.enable = true;

    xserver.enable = true;

    xserver.xkb.layout = "de";
    libinput.enable = true;
  };

  # Consider this!
  # boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alejandra
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
    FLAKE = "/home/h0useofdupree/.dotfiles";
  };
}
