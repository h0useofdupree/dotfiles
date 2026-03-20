{
  config,
  isLaptop,
  lib,
}: let
  appearance = import ./appearance.nix;
  general = import ./general.nix {inherit isLaptop;};
  bar = import ./bar.nix {inherit isLaptop;};
  launcher = import ./launcher.nix {inherit isLaptop;};
  features = import ./features.nix {inherit config isLaptop;};
in
  lib.foldl' lib.recursiveUpdate {} [
    appearance
    general
    bar
    launcher
    features
  ]
