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
      ".config/ags/config.js".source = ./config.js;
      ".config/ags/corners.js".source = ./corners.js;
    };
  };
}
