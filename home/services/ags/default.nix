{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  home = {
    packages = [
      inputs.ags.packages.${pkgs.system}.ags
    ];
    file = {
      ".config/ags/config.js".source =
        ./config.js;

      ".config/ags/screencorners/main.js".source =
        ./screencorners/main.js;

      ".config/ags/screencorners/cairo_corners.js".source =
        ./screencorners/cairo_corners.js;
    };
  };
}
