{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    overlay.enable = true;
  };
  pkgs.overlays = [
    inputs.hyprpanel.overlay
  ];
}
