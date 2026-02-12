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
    ];
  };
}
