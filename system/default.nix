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
  ];

  laptop =
    desktop
    ++ [
      ./services/backlight.nix
      ./services/power.nix
    ];
in {
  inherit desktop laptop;
}
