{
  pkgs,
  inputs,
  ...
}: {
  programs.waybar.enable = false;
  #programs.waybar.package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;
}
