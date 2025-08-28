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
    "dll0945:00-04f3:311c-touchpad"
  ];
in {
  wayland.windowManager.hyprland.settings =
    {
      monitorv2 = [
        {
          output = "eDP-1";
          mode = "1920x1200@60";
          position = "auto";
          scale = 1.0;
          transform = 0;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1.0;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1.0;
          mirror = "eDP-1";
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
