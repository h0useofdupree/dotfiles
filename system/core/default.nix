{lib, ...}:
# Default config shared by all hosts
{
  imports = [
    ./security.nix
    ./users.nix
    ../nix
  ];

  documentation.dev.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "de_DE.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };

  # WARN: DO NOT TOUCH THIS
  system.stateVersion = "24.11";

  time.timeZone = lib.mkDefault "Europe/Berlin";
}
