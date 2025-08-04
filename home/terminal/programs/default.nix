{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./cli.nix
    ./fzf.nix
    ./git.nix
    ./nix.nix
    ./zoxide.nix
    ./xdg.nix
    ./yazi
  ];

  home.packages = with pkgs; [
    cava
  ];
}
