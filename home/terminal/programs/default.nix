{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./cli.nix
    ./git.nix
    ./nix.nix
    ./xdg.nix
    ./yazi
  ];

  home.packages = with pkgs; [
    cava
  ];
}
