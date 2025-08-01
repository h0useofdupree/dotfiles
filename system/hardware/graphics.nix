{
  pkgs,
  inputs,
  ...
}: let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  # Graphic drivers / HW accel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    package = pkgs-unstable.mesa;
    package32 = pkgs-unstable.pkgsi686Linux.mesa;

    extraPackages = with pkgs; [
      libva # VA-API video accleration
      vaapiVdpau # Legacy bridge
      # amdvlk
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
    ];
  };
}
