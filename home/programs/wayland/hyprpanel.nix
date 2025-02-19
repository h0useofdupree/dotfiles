_: {
  programs.hyprpanel = {
    enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    overlay.enable = true;

    theme = "catppuccin_frappe_split";

    layout = {
      "bar.layouts" = {
        "0" = {
          left = ["dashboard" "workspaces" "media"];
          middle = ["windowtitle"];
          right = ["volume" "bluetooth" "network" "battery" "systray" "notifications" "clock"];
        };
      };
    };

    # TODO: fonts,
    settings = {
      menus = {
        clock.weather = {
          enabled = true;
          location = "Mettmann";
          unit = "metric";
          key = "55b82b6781af4a4c9b2165259221802";
        };
        dashboard = {
          shortcuts.enabled = true;
          stats = {
            enabled = true;
            enable_gpu = true;
            interval = 2000;
          };
        };
      };
      theme = {
        bar = {
          location = "top";
          floating = false;
          margin_sides = "1.5em";
          transparent = false;
          outer_spacing = "0.3em";
          border_radius = "1.0em";

          buttons = {
            enableBorders = false;
            radius = "2em";
          };
        };
      };

      bar = {
        launcher = {
          icon = "";
        };
      };

      wallpaper.enable = true;
    };
  };
}
