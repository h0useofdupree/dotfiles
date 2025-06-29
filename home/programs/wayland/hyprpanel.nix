{
  programs.hyprpanel = {
    enable = true;
    # overwrite.enable = true;
    # overlay.enable = true;
    # theme = "catppuccin_frappe_split";

    settings = {
      "bar.layouts" = {
        "*" = {
          left = ["dashboard" "workspaces" "media" "cava"];
          middle = ["windowtitle"];
          right = ["volume" "bluetooth" "network" "battery" "systray" "notifications" "clock"];
        };
      };
      "bar.customModules.cava" = {
        showIcon = false;
        showActiveOnly = true;
      };
      "bar.clock.format" = "%a %b %d %H:%M";
      "menus.clock.time.hideSeconds" = false;
      "menus.clock.weather" = {
        enabled = true;
        location = "Mettmann";
        unit = "metric";
        key = "55b82b6781af4a4c9b2165259221802";
      };
      "menus.dashboard.shortcuts.enabled" = true;
      "menus.dashboard.stats.enabled" = true;
      "menus.dashboard.stats.enable_gpu" = true;
      "menus.dashboard.stats.interval" = 2000;

      "theme.bar.location" = "top";
      "theme.bar.floating" = true;
      "theme.bar.margin_sides" = "1.5em";
      "theme.bar.transparent" = false;
      "theme.bar.outer_spacing" = "0.3em";
      "theme.bar.border_radius" = "1.0em";
      "theme.bar.buttons.enableBorders" = false;
      "theme.bar.buttons.radius" = "2em";

      "bar.launcher.icon" = "";
      "wallpaper.enable" = false;
    };
  };
}
