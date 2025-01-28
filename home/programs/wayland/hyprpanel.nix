_: {
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    overlay.enable = true;

    theme = "catppuccin_mocha";

    layout = {
      "bar.layouts" = {
        "0" = {
          left = ["dashboard" "workspaces" "media"];
          middle = ["windowtitle"];
          right = ["volume" "bluetooth" "network" "battery" "systray" "clock" "notifications"];
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
          floating = true;
          margin_sides = "1.5em";
          transparent = false;
          outer_spacing = "0.3em";
          border_radius = "0.9em";

          buttons = {
            enableBorders = true;
            radius = "0.9em";
          };
        };
      };

      wallpaper.enable = false;
    };
  };
}
