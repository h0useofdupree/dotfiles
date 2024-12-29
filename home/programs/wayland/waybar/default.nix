{pkgs, inputs, ...}: {
    programs.waybar.enable = true;
    #programs.waybar.package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;
}
