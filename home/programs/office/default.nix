{pkgs, ...}: {
  imports = [
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    libreoffice
    obsidian
    texlive.combined.scheme-small
    pandoc
    # TODO: Add some notion stuff if possible
  ];
}
