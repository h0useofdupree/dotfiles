let
  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);

  toggle = program: let
    prog = builtins.substring 0 14 program;
  in "pkill ${prog} || uwsm app -- ${program}";

  runOnce = program: "pgrep ${program} || uwsm app -- ${program}";
in {
  wayland.windowManager.hyprland.settings = {
    # mouse movements
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    # binds
    bind =
      [
        # compositor commands
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod SHIFT, Q, killactive,"
        "$mod SHIFT, D, fullscreen, 0"
        "$mod, D, fullscreen, 1"
        "$mod, G, togglegroup,"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, S, togglesplit,"
        "$mod, f, togglefloating,"
        "$mod SHIFT, f, pseudo,"
        "$mod ALT, ,resizeactive,"

        # utility
        # terminal
        "$mod, Return, exec, uwsm app -- kitty"
        # logout menu
        "Control $mod, Delete, exec, ${toggle "wlogout"} -p layer-shell"
        # lock screen
        "$mod $mod2, L, exec, ${runOnce "hyprlock"}"
        # select area to perform OCR on
        "$mod, O, exec, ${runOnce "wl-ocr"}"
        ", XF86Favorites, exec, ${runOnce "wl-ocr"}"
        # open calculator
        ", XF86Calculator, exec, ${toggle "gnome-calculator"}"
        # open settings
        "$mod, U, exec, XDG_CURRENT_DESKTOP=gnome ${runOnce "gnome-control-center"}"

        # move focus
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        "$mod, Tab, cyclenext"
        "$mod, Tab, bringactivetotop"

        # move window
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        # screenshot
        # area
        "$mod, Print, exec, ${runOnce "grimblast"} --notify copysave area"

        # current screen
        "CTRL, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave output"
        "$mod SHIFT CTRL, R, exec, ${runOnce "grimblast"} --notify --cursor copysave output"

        # all screens
        "ALT, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave screen"
        "$mod SHIFT ALT, R, exec, ${runOnce "grimblast"} --notify --cursor copysave screen"

        # special workspace
        "$mod SHIFT, grave, movetoworkspace, special"
        "$mod, grave, togglespecialworkspace, eDP-1"

        # cycle workspaces
        "$mod, bracketleft, workspace, m-1"
        "$mod, bracketright, workspace, m+1"

        # cycle monitors
        "$mod SHIFT, bracketleft, focusmonitor, l"
        "$mod SHIFT, bracketright, focusmonitor, r"
      ]
      ++ workspaces;

    binde = [
      "$mod2 SHIFT, h, resizeactive, -10% 0"
      "$mod2 SHIFT, l, resizeactive, 10% 0"
      "$mod2 SHIFT, j, resizeactive, 0 10%"
      "$mod2 SHIFT, k, resizeactive, 0 -10%"
    ];

    bindr = [
      # launcher
      "$mod, R, exec, ${toggle "anyrun"}"
    ];

    bindl = [
      # media controls
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # volume
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindle = [
      # volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

      # backlight
      ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
      ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
    ];
  };
}
