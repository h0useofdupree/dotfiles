{
  pkgs,
  self,
  lib,
  config,
  ...
}: {
  imports = [
    "${self}/hosts/linx/hardware-configuration.nix"
  ];
  age = {
    secrets = {
      spotify-client-id = {
        file = "${self}/secrets/spotify-client-id.age";
        owner = "h0useofdupree";
        group = "users";
      };

      openai-api-key = {
        file = "${self}/secrets/openai-api-key.age";
        owner = "h0useofdupree";
        group = "users";
      };

      # weatherapi-key = {
      #   file = "${self}/secrets/weatherapi-key.age";
      #   owner = "h0useofdupree";
      #   group = "users";
      # };
    };
  };

  networking.hostName = "linx";

  services = {
    fstrim.enable = true;

    xserver.xkb.layout = "de";
    libinput.enable = true;
  };

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Set user preferences for environment variables
  environment.variables = {
    LC_TIME = "de_DE.UTF-8"; # Time format
    LC_NUMERIC = "de_DE.UTF-8"; # Numeric format
    LC_MONETARY = "de_DE.UTF-8"; # Currency
    LC_MEASUREMENT = "de_DE.UTF-8"; # Units (e.g., metric)
    LANG = "en_US.UTF-8"; # Interface language
    NH_FLAKE = "/home/h0useofdupree/.dotfiles";
    OPENAI_API_KEY = "$(${pkgs.coreutils}/bin/cat ${config.age.secrets.openai-api-key.path})";
  };
}
