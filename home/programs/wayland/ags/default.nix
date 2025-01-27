{inputs, ...}: {
  imports = [inputs.ags.homeManagerModules.default];

  # TODO: Clean up these paths
  home = {
    file = {
      ".config/ags/config.js".source =
        ./../../../../modules/ags/config.js;

      ".config/ags/screencorners/main.js".source =
        ./../../../../modules/ags/screencorners/main.js;

      ".config/ags/screencorners/cairo_corners.js".source =
        ./../../../../modules/ags/screencorners/cairo_corners.js;
    };
  };
}
