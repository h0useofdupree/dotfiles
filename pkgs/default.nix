{inputs, ...}: {
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      repl = pkgs.callPackage ./repl {};

      bibata-hyprcursor = pkgs.callPackage ./bibata-hyprcursor {};

      wl-ocr = pkgs.callPackage ./wl-ocr {};

      speakerctl = pkgs.callPackage ./speakerctl {};

      dynamic-wallpaper = pkgs.callPackage ./dynamic-wallpaper {};

      # caelestia-colors = pkgs.callPackage ./caelestia-colors {};

      caelestia-shell = inputs.caelestia-shell.packages.${pkgs.system}.default;
    };
  };
}
