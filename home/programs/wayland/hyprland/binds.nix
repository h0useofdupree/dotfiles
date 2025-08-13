{
  pkgs,
  isLaptop ? false,
  ...
}: let
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

  toggleFloatResize = pkgs.writeShellScriptBin "toggle-float-resize" ''
    STATE=$(hyprctl -j activewindow | jaq ".floating")
    SIZE=$(hyprctl -j activewindow | jaq -r '.size | "\(.[0]) \(.[1])"')

    if [ "$STATE" = "false" ]; then
        hyprctl --batch "\
            dispatch togglefloating;\
            dispatch resizeactive exact 1440 810;\
            dispatch centerwindow"
    else
        if [ "$SIZE" != "1440 810" ]; then
            hyprctl --batch "\
                dispatch resizeactive exact 1440 810;\
                dispatch centerwindow"
        else
            hyprctl dispatch togglefloating
        fi
    fi
  '';
  brightnessUp =
    if isLaptop
    then "brillo -q -u 300000 -A 5"
    else "ddcutil setvcp 10 + 10";
  brightnessDown =
    if isLaptop
    then "brillo -q -u 300000 -U 5"
    else "ddcutil setvcp 10 - 10";
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
        "$mod SHIFT, R, exec, hyprctl reload"
        "$mod2 SHIFT, R, exec, systemctl --user restart caelestia-shell.service"
        "$mod, Q, killactive,"
        "$mod SHIFT, D, fullscreen, 0"
        "$mod, D, fullscreen, 1"
        "$mod, G, togglegroup,"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, S, togglesplit,"
        "$mod SHIFT, F, exec, ${toggleFloatResize}/bin/toggle-float-resize"
        "$mod, F, pseudo,"
        "$mod, M, layoutmsg, swapwithmaster"
        "$mod SHIFT, M, layoutmsg, orientationcycle left center"

        # utility
        # terminal
        "$mod, Return, exec, uwsm app -- kitty"

        #browsers
        "$mod, B, exec, uwsm app -- zen"
        "$mod2, B, exec, uwsm app -- qutebrowser"

        # logout menu
        # "Control $mod, Delete, exec, ${toggle "wlogout"} -p layer-shell"
        "Control $mod, Delete, global, caelestia:session"

        # lock screen
        "$mod $mod2, L, exec, ${runOnce "hyprlock"}"
        # "$mod, L, global, systemctl --user start caelestia-shell.service"
        "$mod2, L, global, caelestia:lock"

        # select area to perform OCR on
        "$mod, O, exec, ${runOnce "wl-ocr"}"
        ", XF86Favorites, exec, ${runOnce "wl-ocr"}"

        # gnome-apps
        "$mod, C, exec, ${toggle "gnome-calculator"}"
        "$mod SHIFT, C, exec, [float; center] ${toggle "gnome-clocks"}"

        # open settings
        # "$mod, U, exec, XDG_CURRENT_DESKTOP=gnome ${runOnce "gnome-control-center"}"

        # Caelestia misc
        "$mod SHIFT, n, global, caelestia:clearNotifs"
        "$mod, a, global, caelestia:showall"
        "$mod, m, exec, caelestia shell drawers toggle dashboard"

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
        ## area
        # "$mod, Next, exec, ${runOnce "grimblast"} --notify copysave area"
        "$mod, Next, global, caelestia:screenshot"

        ## area freeze
        "$mod SHIFT, Next, global, caelestia:screenshotFreeze"

        ## current screen
        # "$mod, Prior, exec, ${runOnce "grimblast"} --notify --cursor copysave output"
        "$mod, Prior, exec, caelestia screenshot"

        ## all screens
        # "$mod $mod2, Next, exec, ${runOnce "grimblast"} --notify --cursor copysave screen"

        # screen-recording
        ## Sound
        "$mod, Insert, exec, caelestia record -s"
        ## No-Sound
        "$mod SHIFT, Insert, exec, caelestia record"

        # special workspace
        "$mod SHIFT, code:20, movetoworkspace, special"
        "$mod, code:20, togglespecialworkspace"

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
      # "$mod, R, exec, ${toggle "anyrun"}"
      "$mod, R, global, caelestia:launcher"
    ];

    bindl = [
      # media controls
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # volume
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      # speaker control
      "$mod2, 1, exec, speakerctl --on"
      "$mod2, 0, exec, speakerctl --off"
    ];

    bindle = [
      # volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%-"

      # backlight
      ", XF86MonBrightnessUp, exec, ${brightnessUp}"
      ", XF86MonBrightnessDown, exec, ${brightnessDown}"
    ];
  };
}
