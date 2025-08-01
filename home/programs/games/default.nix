{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./vesktop.nix
  ];

  home.packages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    gamescope
    # (lutris.override {extraPkgs = p: [p.libnghttp2];})
    winetricks
  ];
}
