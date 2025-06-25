let
  mkKeyboard = {
    kb_layout = "us";
    kb_variant = "altgr-intl";
    kb_options = "compose:caps, level3:ralt_switch";
  };
in {
  programs.hyprland.settings = {
    monitor = [
      "eDP-1, 1920x1200@60, auto, 1"
      ", preferred, auto, 1"
      ", preferred, auto, 1, mirror, eDP-1"
    ];
    "device[keychron-keychron-q1]" = mkKeyboard;
    "device[keychron-keychron-q1-keyboard]" = mkKeyboard;
  };
}
