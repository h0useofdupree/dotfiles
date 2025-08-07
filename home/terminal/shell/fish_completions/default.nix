{pkgs, ...}: {
  xdg.configFile."fish/completions/bat.fish".source = ./bat.fish;
  xdg.configFile."fish/completions/nix.fish".source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";
}
