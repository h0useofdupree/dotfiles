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

  programs = {
    direnv = {
      enable = true;
      config.global.hide_env_diff = true;
      nix-direnv.enable = true;
    };
    direnv-instant = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableKittyIntegration = true;
      settings = {
        use_cache = true;
      };
    };
  };
}
