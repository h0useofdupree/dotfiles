{
  config,
  lib,
  pkgs,
  ...
}: let
  # pointer = config.home.pointerCursor;
  cursorName = "Bibata-Modern-Classic-Hyprcursor";
in {
  programs.hyprland.settings = {
    "$mod" = "ALT";
    "$mod2" = "SUPER";
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "HYPRCURSOR_THEME,${cursorName}"
      "HYPRCURSOR_SIZE,${toString 16}"
      "GRIMBLAST_NO_CURSOR,0"
    ];

    exec-once = [
      # finalize startup
      "uwsm finalize"
      # set cursor for HL itself
      "hyprctl setcursor ${cursorName} ${toString 16}"
      "hyprlock"
      "hyprpanel"
      "ags"
    ];

    general = {
      # layout = "master";
      layout = "dwindle";
      gaps_in = 15;
      gaps_out = 20;
      border_size = 3;
      "col.active_border" = "rgba(88888888)";
      "col.inactive_border" = "rgba(00000088)";

      allow_tearing = true;
      resize_on_border = false;
    };

    decoration = {
      rounding = 18;
      rounding_power = 4;
      dim_special = 0;
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

        special = true;
      };

      shadow = {
        enabled = true;
        color = "rgba(00000055)";
        ignore_window = true;
        offset = "0 2";
        range = 20;
        render_power = 4;
        scale = 0.97;
      };
    };

    animations.enabled = true;

    bezier = [
      "easeOutQuint,0.23,1,0.32,1"
      "easeInOutCubic,0.65,0.05,0.36,1"
      "linear,0,0,1,1"
      "almostLinear,0.5,0.5,0.75,1.0"
      "quick,0.15,0,0.1,1"
    ];

    animation = [
      "global, 1, 4, default"
      "border, 1, 5, easeOutQuint"
      # "windows, 1, 3, easeOutQuint, popin 80%"
      "windows, 1, 4, default, gnomed"
      "fade, 1, 3, quick"
      "layers, 1, 4, easeInOutCubic, slide top"
      "layersIn, 1, 2, easeOutQuint, slide top"
      "layersOut, 1, 3, linear, slide top"
      "fadeLayersIn, 1, 2, almostLinear"
      "fadeLayersOut, 1, 3, almostLinear"
      "workspaces, 1, 2, almostLinear, slide"
      "specialWorkspace, 1, 2, almostLinear, slidevert"
    ];

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

    dwindle = {
      pseudotile = true;
      preserve_split = true;
      special_scale_factor = 0.7;
    };

    master = {
      orientation = "center";
      allow_small_split = true;
      slave_count_for_center_master = 0;
      new_status = "slave";
      new_on_top = false;
      mfact = 0.55;
      special_scale_factor = 0.7;
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

    render = {
      direct_scanout = true;
    };

    # touchpad gestures
    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    permission = [
      "${config.programs.hyprland.portalPackage}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
      "${lib.getExe pkgs.grim}, screencopy, allow"
      "${lib.getExe pkgs.wl-screenrec}, screencopy, allow"
    ];

    xwayland.force_zero_scaling = true;

    debug.disable_logs = false;

    hyprbars-button = [
      # close
      "rgb(ffb4ab), 15, , hyprctl dispatch killactive"
      # maximize
      "rgb(b6c4ff), 15, , hyprctl dispatch fullscreen 1"
    ];

    plugin = {
      hyprbars = {
        bar_height = 20;
        bar_precedence_over_border = true;
        icon_on_hover = true;
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
