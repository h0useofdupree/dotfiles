let
  mkKeyboard = {
    kb_layout = "us";
    kb_variant = "altgr-intl";
    kb_options = "ctrl:nocaps, level3:ralt_switch";
  };

  accelpoints = "0.5 0.000 0.053 0.115 0.189 0.280 0.391 0.525 0.687 0.880 1.108 1.375 1.684 2.040 2.446 2.905 3.422 4.000 4.643 5.355 6.139";

  mkTrackpad = {
    accel_profile = "custom ${accelpoints}";
    scroll_points = accelpoints;
    natural_scroll = true;
  };

  trackpadDevices = [
    "apple-inc.-magic-trackpad"
    "apple-inc.-magic-trackpad-usb-c"
  ];
in {
  wayland.windowManager.hyprland.settings =
    {
      monitorv2 = [
        {
          # LG 34GN850P
          output = "DP-1";
          mode = "3440x1440@160";
          position = "auto";
          scale = 1.0;
          transform = 0;
          bitdepth = 10;
          cm = "auto";
          # cm = "hdr";
          vrr = 0;
          sdrbrightness = 1.4;
          sdrsaturation = 1.0;
        }
        {
          # LG 27GR75Q-B
          output = "DP-2";
          mode = "2560x1440@180";
          position = "auto-left";
          scale = 1.0;
          transform = 0;
          bitdepth = 10;
          cm = "auto";
          # cm = "hdr";
          vrr = 0;
          sdrbrightness = 1.4;
          sdrsaturation = 1.0;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1.0;
        }
      ];
      "device[keychron-keychron-q1]" = mkKeyboard;
      "device[keychron-keychron-q1-keyboard]" = mkKeyboard;
    }
    // builtins.listToAttrs (map (name: {
        name = "device[${name}]";
        value = mkTrackpad;
      })
      trackpadDevices);
}
