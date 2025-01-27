_: {
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    overlay.enable = true;

    theme = "rose_pine";

    layout = {
      "bar.layouts" = {
        "0" = {
          left = ["dashboard" "workspaces" "media"];
          middle = ["windowtitle"];
          right = ["volume" "bluetooth" "network" "battery" "systray" "clock" "notifications"];
        };
      };
    };

    settings = {
      menus = {
        clock.weather = {
          enabled = true;
          location = "Mettmann";
          unit = "metric";
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
        };
      };
    };
  };
}
