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
    inputs.nixvim.homeManagerModules.nixvim
    inputs.hyprpanel.homeManagerModules.hyprpanel
    self.nixosModules.theme
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
    inputs.hyprpanel.overlay
    (final: prev: {
      lib = prev.lib // {colors = import "${self}/lib/colors" lib;};
    })
  ];
}
