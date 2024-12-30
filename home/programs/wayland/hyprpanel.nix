{...}: {
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = false;
    overwrite.enable = false;
  };
}
