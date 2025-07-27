{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.nixosModules.default

    ./binds.nix
    ./rules.nix
    ./settings.nix
    # ./smartgaps.nix
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    plugins = let
      hyprlandPlugins = inputs.hyprland-plugins.packages.${pkgs.system};
    in
      with hyprlandPlugins; [
        hyprbars
        hyprexpo
        # hyprfocus
        # inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
      ];

    # systemd = {
    #   enable = false;
    #   variables = ["--all"];
    #   extraCommands = [
    #     "systemctl --user stop graphical-session.target"
    #     "systemctl --user start hyprland-session.target"
    #   ];
    # };
  };

  environment = {
    systemPackages = [
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      inputs.self.packages.${pkgs.system}.bibata-hyprcursor
    ];

    pathsToLink = ["/share/icons/"];
    variables.NIXOS_OZONE_WL = "1";
  };
}
