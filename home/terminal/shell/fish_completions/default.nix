{
  pkgs,
  inputs,
  ...
}: {
  xdg = {
    configFile = {
      "fish/completions/bat.fish" = {
        source = ./bat.fish;
      };
      "fish/completions/codex.fish" = {
        source = ./codex.fish;
      };
      "fish/completions/nix.fish" = {
        source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";
      };
      "fish/completions/dynamic-wallpaper.fish" = {
        source = "${inputs.self.packages.${pkgs.system}.dynamic-wallpaper}/share/fish/vendor_completions.d/dynamic-wallpaper.fish";
      };
    };
  };
}
