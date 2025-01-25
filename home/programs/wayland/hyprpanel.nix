{...}: {
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
          right = ["volume" "bluetooth" "network" "power" "systray" "clock" "notifications"];
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
      };
    };
  };
}
