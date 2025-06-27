let
  mkKeyboard = {
    kb_layout = "us";
    kb_variant = "altgr-intl";
    kb_options = "compose:caps, level3:ralt_switch";
  };
in {
  programs.hyprland.settings = {
    monitor = [
      "DP-1, 3440x1440@144, auto, 1, cm, auto"
      ", preferred, auto, 1"
    ];

    "device[keychron-keychron-q1]" = mkKeyboard;
    "device[keychron-keychron-q1-keyboard]" = mkKeyboard;
  };
}
