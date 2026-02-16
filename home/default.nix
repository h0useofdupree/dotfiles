{
  self,
  inputs,
  ...
}: {
  imports = [
    ./specialisations.nix
    ./terminal

    inputs.nix-index-db.homeModules.nix-index
    # TODO: Put these imports into their respective files ({default,<name>}.nix)
    inputs.nvf.homeManagerModules.default
    inputs.direnv-instant.homeModules.direnv-instant
    inputs.agenix.homeManagerModules.default
    self.modules.theme
    inputs.self.homeModules.dynamicWallpaper
    inputs.self.homeModules.speakerctl
  ];

  home = {
    username = "h0useofdupree";
    homeDirectory = "/home/h0useofdupree";
    stateVersion = "24.11";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;
}
