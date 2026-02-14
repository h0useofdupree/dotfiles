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
    self.packages.${pkgs.stdenv.hostPlatform.system}.repl
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
