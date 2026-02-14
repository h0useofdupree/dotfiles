{
  inputs,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  programs.hyprland = {
    enable = true;
    withUWSM = true;

    package = inputs.hyprland.packages.${system}.default;
    portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
  };

  # Make Electron/Chromium run on wayland
  environment.variables.NIXOS_OZONE_WL = "1";
}
