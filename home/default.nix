{
  lib,
  self,
  inputs,
  ...
}: {
  imports = [
    ./specialisations.nix
    ./terminal
    inputs.nix-index-db.hmModules.nix-index
    # TODO: Put these imports into their respective files ({default,<name>}.nix)
    # inputs.hyprpanel.homeManagerModules.hyprpanel
    inputs.nvf.homeManagerModules.default
    self.nixosModules.theme
    inputs.self.homeModules.dynamicWallpaper
  ];

  home = {
    username = "h0useofdupree";
    homeDirectory = "/home/h0useofdupree";
    stateVersion = "24.11"; # Please read the comment before changing.
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      lib = prev.lib // {colors = import "${self}/lib/colors" lib;};
    })
  ];
}
