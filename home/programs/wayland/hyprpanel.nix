{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;

    settings = {
      # Bar: Layouts
      "bar.layouts" = {
        "*" = {
          left = ["dashboard" "workspaces" "media"];
          middle = ["windowtitle"];
          right = ["volume" "bluetooth" "network" "battery" "systray" "notifications" "clock"];
        };
      };
      bar = {
        clock.format = "%a %b %d %H:%M";
        customModules = {
          cava = {
            showIcon = false;
            showActiveOnly = true;
          };
        };
        launcher.icon = "";
        # TODO: Find out where to put these
        shadow = "0px 0px 0px 0px #16161e";
        shadowMargins = "10px 10px";
      };
      tear = true;

      menus = {
        clock = {
          time.hideSeconds = false;
          weather = {
            enabled = true;
            location = "Mettmann";
            unit = "metric";
            key = "55b82b6781af4a4c9b2165259221802";
          };
        };

        dashboard = {
          # "menus.dashboard.powermenu.avatar.image" = "/home/h0useofdupree/.cache/dynamic-wallpaper/current"; # Use default: ~/.face.icon
          # TODO: Encrypt ~/.face.icon with age(nix) and add to repo
          shortcuts.enabled = true;
          stats = {
            enabled = true;
            enable_gpu = false;
            interval = 2000;
          };
        };
      };

      wallpaper = {
        enable = false;
        # Choose image for matugen
        image = "/home/h0useofdupree/.cache/dynamic-wallpaper/current";
      };
      theme = {
        matugen = true;
        matugen_settings = {
          mode = "dark";
          scheme_type = "monochrome";
          variation = "standard_1";
        };
        bar = {
          border_radius = "1.0em";
          buttons = {
            enableBorders = false;
            radius = "0.85em";
            spacing = "0.3em";
            padding_x = "1.0em";
            background_opacity = "0";
          };
          floating = false;
          location = "top";
          margin_sides = "1.5em";
          menus = {
            border.radius = "1.5em";
            card_radius = "1.5em";
            popover.radius = "1.5em";
            opacity = "60";
          };
          opacity = "30";
          outer_spacing = "0.5em";
          transparent = false;
          workspaces.showApplicationIcons = true;
        };
        osd = {
          location = "top";
          orientation = "horizontal";
        };
      };
    };
  };
}
