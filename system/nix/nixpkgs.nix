{self, ...}: {
  nixpkgs = {
    config = {
      # NOTE: Still unsure why this was needed
      replaceStdenv = {pkgs, ...}: pkgs.stdenv;

      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };

    overlays = [
      (final: prev: {
        lib =
          prev.lib
          // {
            colors = import "${self}/lib/colors" prev.lib;
          };
      })
      # NOTE: Temporary workaround for Material Symbols variable font lookup lag in Caelestia/Quickshell.
      (final: prev: {
        material-symbols = prev.material-symbols.overrideAttrs (old: {
          postInstall =
            (old.postInstall or "")
            + ''
              ln -s "$out/share/fonts/TTF/MaterialSymbolsRounded.ttf" "$out/share/fonts/TTF/MaterialSymbolsRounded[FILL,GRAD,opsz,wght].ttf"
              ln -s "$out/share/fonts/TTF/MaterialSymbolsOutlined.ttf" "$out/share/fonts/TTF/MaterialSymbolsOutlined[FILL,GRAD,opsz,wght].ttf"
              ln -s "$out/share/fonts/TTF/MaterialSymbolsSharp.ttf" "$out/share/fonts/TTF/MaterialSymbolsSharp[FILL,GRAD,opsz,wght].ttf"
            '';
        });
      })
    ];
  };
}
