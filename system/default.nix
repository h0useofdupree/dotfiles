let
  desktop = [
    ./core
    ./core/boot.nix

    ./hardware/graphics.nix
    ./hardware/bluetooth.nix

    ./network

    ./programs

    ./services
    ./services/greetd.nix
    ./services/pipewire.nix
    ./services/openrgb.nix
  ];

  laptop =
    desktop
    ++ [
      ./services/backlight.nix
      ./services/power.nix
      ./services/fwupd.nix
    ];
in {
  inherit desktop laptop;
}
