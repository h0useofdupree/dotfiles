{
  inputs,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  cursor = "Bibata-Modern-Classic-Hyprcursor";
  cursorPackage = inputs.self.packages.${system}.bibata-hyprcursor;
in {
  imports = [
    ./binds.nix
    ./rules.nix
    ./settings.nix
    # ./smartgaps.nix
  ];

  home.packages = [
    inputs.hyprland-contrib.packages.${system}.grimblast
    inputs.self.packages.${system}.bibata-hyprcursor
  ];

  xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.default;

    plugins = with inputs.hyprland-plugins.packages.${system}; [
      hyprbars
      hyprexpo
      # borders-plus-plus
      # hyprfocus
      # inputs.Hyprspace.packages.${system}.Hyprspace
      inputs."split-monitor-workspaces".packages.${system}.split-monitor-workspaces
    ];

    systemd = {
      enable = false;
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
