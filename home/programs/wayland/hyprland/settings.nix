{config, ...}: let
  pointer = config.home.pointerCursor;

  cursorName = "Bibata-Modern-Classic-Hyprcursor";
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "ALT";
    "$mod2" = "SUPER";
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "HYPRCURSOR_THEME,${cursorName}"
      "HYPRCURSOR_SIZE,${toString pointer.size}"
    ];

    exec-once = [
      # finalize startup
      "uwsm finalize"
      # set cursor for HL itself
      "hyprctl setcursor ${cursorName} ${toString pointer.size}"
      "hyprlock"
      #"waybar"
      "hyprpanel"
    ];

    general = {
      gaps_in = 15;
      gaps_out = 20;
      border_size = 3;
      "col.active_border" = "rgba(88888888)";
      "col.inactive_border" = "rgba(00000088)";

      allow_tearing = true;
      resize_on_border = false;
    };

    experimental = {
      hdr = false;
    };

    decoration = {
      rounding = 20;
      rounding_power = 3;
      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.01;

        vibrancy = 0.2;
        vibrancy_darkness = 0.5;

        passes = 4;
        size = 7;

        popups = true;
        popups_ignorealpha = 0.2;
      };

      shadow = {
        enabled = true;
        color = "rgba(00000055)";
        ignore_window = true;
        offset = "0 15";
        range = 100;
        render_power = 2;
        scale = 0.97;
      };
    };

    animations = {
      enabled = true;
      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
      ];
    };

    group = {
      groupbar = {
        font_size = 10;
        gradients = false;
        text_color = "rgb(b6c4ff)";
      };

      "col.border_active" = "rgba(35447988)";
      "col.border_inactive" = "rgba(dce1ff88)";
    };

    input = {
      kb_layout = "de";

      # focus change on cursor move
      follow_mouse = 1;
      accel_profile = "flat";

      touchpad = {
        natural_scroll = "true";
      };
    };

    device = [
      {
        name = "keychron-keychron-q1";
        kb_layout = "us";
        kb_variant = "altgr-intl";
        kb_options = "compose:caps, level3:ralt_switch";
      }

      {
        name = "keychron-keychron-q1-keyboard";
        kb_layout = "us";
        kb_variant = "altgr-intl";
        kb_options = "compose:caps, level3:ralt_switch";
      }
    ];

    dwindle = {
      # keep floating dimentions while tiling
      pseudotile = true;
      preserve_split = true;
    };

    misc = {
      # disable auto polling for config file changes
      disable_autoreload = true;

      force_default_wallpaper = 0;

      # disable dragging animation
      animate_mouse_windowdragging = false;

      enable_swallow = true;
      swallow_regex = "(foot|kitty|alacritty)";
      swallow_exception_regex = "(xev|wev)";

      # enable variable refresh rate (effective depending on hardware)
      vrr = 1;
    };

    render.direct_scanout = true;

    # touchpad gestures
    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    # xwayland.force_zero_scaling = true;

    debug.disable_logs = false;

    plugin = {
      hyprbars = {
        bar_height = 20;
        bar_precedence_over_border = true;
      };

      hyprexpo = {
        columns = 3;
        gap_size = 30;
        bg_col = "rgb(000000)";

        enable_gesture = true;
        gesture_distance = 300;
        gesture_positive = false;
      };

      #overview = {
      #  # Color
      #  panelColor = "rgba(51, 51, 51, 0.133)";
      #  panelBorderColor = "rgba(59, 59, 59, 0.0)";
      #  workspaceActiveBorder = "rgba(255, 255, 255, 1.0)";
      #  workspaceInactiveBorder = "rgba(59, 59, 59, 1.0)";
      #  dragAlpha = 0.9;

      #  # Layout
      #  panelHeight = 300;
      #  panelBorderWidth = 5;
      #  workspaceMargin = 20;
      #  workspaceBorderSize = 2;
      #  onBottom = false;
      #  adaptiveHeight = true;
      #  centerAligned = true;

      #  # Visibility
      #  hideBackgroundLayers = false;
      #  hideTopLayers = true;
      #  hideOverlayLayers = true;
      #  hideRealLayers = true;

      #  # Workspace
      #  drawActiveWorkspace = true;
      #  showNewWorkspace = false;
      #  showEmptyWorkspace = false;
      #  showSpecialWorkspace = true;

      #  # Gaps
      #  affectStruct = false;
      #  overrideGaps = true;
      #  gapsIn = 50;
      #  gapsOut = 50;

      #  # Behavior
      #  autoDrag = true;
      #  autoScroll = true;

      #  # Animation
      #  # overrideAnimSpeed = 5;
      #};
    };
  };
}
