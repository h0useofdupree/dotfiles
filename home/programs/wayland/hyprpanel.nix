{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;

    settings = {
      "bar.layouts" = {
        "*" = {
          left = ["dashboard" "workspaces" "media"];
          middle = ["windowtitle"];
          right = ["volume" "bluetooth" "network" "battery" "systray" "notifications" "clock"];
        };
      };
      "tear" = true;
      "bar.customModules.cava.showIcon" = false;
      "bar.customModules.cava.showActiveOnly" = true;
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
      "menus.dashboard.stats.enable_gpu" = false;
      "menus.dashboard.stats.interval" = 2000;

      "theme.bar.location" = "top";
      "theme.bar.floating" = false;
      "theme.bar.margin_sides" = "1.5em";
      "theme.bar.transparent" = true;
      "theme.bar.outer_spacing" = "0.3em";
      "theme.bar.border_radius" = "1.0em";
      "theme.bar.buttons.enableBorders" = true;
      "theme.bar.buttons.radius" = "0.85em";
      "theme.bar.buttons.spacing" = "1.0em";
      "theme.bar.buttons.padding_x" = "1.0em";
      "theme.bar.workspaces.showApplicationIcons" = true;

      "bar.launcher.icon" = "";
      "wallpaper.enable" = false;
      "wallpaper.image" = "/home/h0useofdupree/.local/share/dynamic-wallpapers/Mojave/mojave_dynamic_1.jpeg";
      "theme.matugen" = true;
    };
  };
}
