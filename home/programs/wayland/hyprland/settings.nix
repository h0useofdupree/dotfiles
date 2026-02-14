{
  config,
  lib,
  pkgs,
  ...
}: let
  # pointer = config.home.pointerCursor;
  cursorName = "Bibata-Modern-Classic-Hyprcursor";
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "ALT";
      "$mod2" = "SUPER";
      source = config.home.homeDirectory + "/.config/hypr/scheme/current.conf";
      env = [
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "HYPRCURSOR_THEME,${cursorName}"
        "HYPRCURSOR_SIZE,${toString 18}"
        "GRIMBLAST_NO_CURSOR,0"
      ];

      exec-once = [
        "uwsm finalize"
        "hyprctl setcursor ${cursorName} ${toString 18}"
        "openrgb --startminimized"
        "sleep 2 && caelestia shell lock lock"
        "hyprctl dispatch focusmonitor DP-1"
      ];

      general = {
        # layout = "master";
        layout = "dwindle";
        gaps_in = 10;
        gaps_out = 15;
        border_size = 5;
        "col.active_border" = "rgba($primaryE6)";
        "col.inactive_border" = "rgba($backgroundE6)";

        allow_tearing = false;
        resize_on_border = false;
      };

      ecosystem = {
        no_update_news = false;
        no_donation_nag = true;
      };

      decoration = {
        rounding = 20;
        rounding_power = 4;
        dim_special = 0;
        blur = {
          enabled = true;
          brightness = 1.0;
          contrast = 1.0;
          noise = 0.01;

          vibrancy = 0.2;
          vibrancy_darkness = 0.5;

          passes = 3;
          size = 6;

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
        auto_group = true;
        insert_after_current = true;
        focus_removed_window = true;
        drag_into_group = 1; # 2 = Only drag into groupbar
        merge_groups_on_drag = true;
        merge_floated_into_tiled_on_groupbar = false;

        groupbar = {
          enabled = true;
          font_size = 13;
          font_weight_active = "bold";
          font_weight_inactive = "normal";
          height = 20;
          indicator_height = 0;
          # rounding = 20;
          # rounding_power = 4;
          round_only_edges = true;
          gradients = true;
          gradient_rounding = 15;
          gradient_rounding_power = 4;
          gradient_round_only_edges = true;
          text_color = "rgba($backgroundE6)";
          text_color_inactive = "rgba($textE6)";
          gaps_in = 5;
          gaps_out = 2;
          keep_upper_gap = true;
          "col.active" = "rgba($primaryE6)";
          "col.inactive" = "rgba($backgroundE6)";
        };

        # TODO: Select proper colors
        "col.border_active" = "rgba($primaryE6)";
        "col.border_inactive" = "rgba($backgroundE6)";
        "col.border_locked_active" = "rgba($primaryE6)";
        "col.border_locked_inactive" = "rgba($backgroundE6)";
      };

      input = {
        kb_layout = "de";
        kb_options = "ctrl:nocaps";

        follow_mouse = 1;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = "true";
          scroll_factor = 1.0;
        };
      };

      cursor = {
        hide_on_key_press = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        special_scale_factor = 0.85;
        # NOTE: Desktop bar/widgets, especially vertical bars affect area for windows.
        default_split_ratio = 1.0;
        single_window_aspect_ratio = "16 9";
      };

      master = {
        orientation = "center";
        slave_count_for_center_master = 0;
        new_status = "slave";
        new_on_top = false;
        mfact = 0.55;
        special_scale_factor = 0.85;
      };

      misc = {
        disable_autoreload = true;

        force_default_wallpaper = 0;

        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;

        enable_swallow = true;
        swallow_regex = "(foot|kitty|alacritty)";
        swallow_exception_regex = "(xev|wev)";
        session_lock_xray = true;

        vrr = 1;
      };

      binds = {
        hide_special_on_workspace_change = true;
      };

      render = {
        direct_scanout = true;
        cm_auto_hdr = 1;
      };

      # touchpad gestures
      gestures = {
        workspace_swipe_forever = true;
        workspace_swipe_cancel_ratio = 0.3;
        workspace_swipe_distance = 1400;
      };

      gesture = [
        "3, horizontal, workspace"
        "3, down, mod: ALT, close"
        "3, pinch, scale: 1.5, fullscreen"

        # TODO: Maybe use toggleFloatResize from binds somehow
        "4, pinch, scale: 1.5, float"
      ];

      hyprexpo-gesture = [
        "4, up, expo, on"
        "4, down, expo, off"
      ];

      permission = [
        "${config.wayland.windowManager.hyprland.portalPackage}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
        "${lib.getExe pkgs.grim}, screencopy, allow"
        "${lib.getExe pkgs.wl-screenrec}, screencopy, allow"
      ];

      xwayland.force_zero_scaling = true;

      debug.disable_logs = false;

      plugin = {
        hyprbars = {
          bar_color = "rgba($backgroundE6)";
          "col.text" = "rgba($onBackgroundFF)";
          bar_height = 25;
          bar_blur = true;
          bar_button_padding = 15;
          bar_button_alignment = "left";
          bar_padding = 15;
          bar_precedence_over_border = true;
          bar_part_of_window = true;
          bar_title_enabled = false;
          icon_on_hover = true;
          on_double_click = "hyprctl dispatch fullscreen 1";
        };

        borders-plus-plus = {
          add_borders = 0;
          "col.border_1" = "rgba($backgroundE6)";
          border_size_1 = 6;
          natural_rounding = "yes";
        };

        split-monitor-workspaces = {
          count = 10;
          keep_focused = true;
          enable_notifications = false;
          enable_persistent_workspaces = true;
          enable_wrapping = true;
        };

        hyprexpo = {
          columns = 3;
          gap_size = 30;
          bg_col = "rgba($backgroundE6)";
          workspace_method = "center current";
          skip_empty = true;
          gesture_distance = 300;
        };

        overview = {
          # Color
          panelColor = "rgba(51, 51, 51, 0.133)";
          panelBorderColor = "rgba(59, 59, 59, 0.0)";
          workspaceActiveBorder = "rgba(255, 255, 255, 1.0)";
          workspaceInactiveBorder = "rgba(59, 59, 59, 1.0)";
          dragAlpha = 0.9;

          # Layout
          panelHeight = 300;
          panelBorderWidth = 5;
          workspaceMargin = 20;
          workspaceBorderSize = 2;
          onBottom = false;
          adaptiveHeight = true;
          centerAligned = true;

          # Visibility
          hideBackgroundLayers = false;
          hideTopLayers = true;
          hideOverlayLayers = true;
          hideRealLayers = true;

          # Workspace
          drawActiveWorkspace = true;
          showNewWorkspace = false;
          showEmptyWorkspace = false;
          showSpecialWorkspace = true;

          # Gaps
          affectStruct = false;
          overrideGaps = true;
          gapsIn = 50;
          gapsOut = 50;

          # Behavior
          autoDrag = true;
          autoScroll = true;

          # Animation
          # overrideAnimSpeed = 5;
        };
      };
    };
    # TODO: Fix buttons
    extraConfig = ''
      # hyprlang noerror true
      hyprbars-button = rgba($errorContainerAA), 15, , hyprctl dispatch killactive
      hyprbars-button = rgba($tertiaryAA), 15, 󰖯, hyprctl dispatch fullscreen 1
      # hyprlang noerror false
    '';
  };
}
