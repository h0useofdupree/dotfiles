let
  mkKeyboard = {
    kb_layout = "us";
    kb_variant = "altgr-intl";
    kb_options = "ctrl:nocaps, level3:ralt_switch";
  };
  accelpoints = "0.5 0.000 0.053 0.115 0.189 0.280 0.391 0.525 0.687 0.880 1.108 1.375 1.684 2.040 2.446 2.905 3.422 4.000 4.643 5.355 6.139";
in {
  programs.hyprland.settings = {
    monitor = [
      "eDP-1, 1920x1200@60, auto, 1"
      ", preferred, auto, 1"
      ", preferred, auto, 1, mirror, eDP-1"
    ];
    "device[keychron-keychron-q1]" = mkKeyboard;
    "device[keychron-keychron-q1-keyboard]" = mkKeyboard;
    "device[dll0945:00-04f3:311c-touchpad]" = {
      accel_profile = "custom ${accelpoints}";
      scroll_points = accelpoints;
      natural_scroll = true;
    };
  };
}
