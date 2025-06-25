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

  environment.systemPackages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    inputs.self.packages.${pkgs.system}.bibata-hyprcursor
  ];

  environment.pathsToLink = ["/share/icons/"];

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      hyprbars
      hyprexpo
    ];

    # systemd = {
    #   enable = false;
    #   variables = ["--all"];
    #   extraCommands = [
    #     "systemctl --user stop graphical-session.target"
    #     "systemctl --user start hyprland-session.target"
    #   ];
    # };

    environment.variables.NIXOS_OZONE_WL = "1";
  };
}
