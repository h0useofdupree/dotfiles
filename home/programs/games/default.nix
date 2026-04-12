{
  pkgs,
  inputs,
  lib,
  isLaptop,
  ...
}: {
  imports = [
    ./vesktop.nix
  ];

  home.packages = with pkgs;
    [
      (discord.override {
        withVencord = true;
      })
      inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
      gamescope
      heroic
      lutris
      # (lutris.override {extraPkgs = p: [p.libnghttp2];})
      mangohud
      winetricks
      protontricks

      prismlauncher
    ]
    ++ lib.optional (!isLaptop) oversteer;
}
