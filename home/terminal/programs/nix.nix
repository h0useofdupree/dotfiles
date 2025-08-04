{
  pkgs,
  self,
  ...
}: {
  home.packages = with pkgs; [
    alejandra
    deadnix
    nixd
    statix
    self.packages.${pkgs.system}.repl
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
