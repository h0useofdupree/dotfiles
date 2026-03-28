{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    # layer rules
    layerrule = let
      toRegex = list: let
        elements = lib.concatStringsSep "|" list;
      in "match:namespace ^(${elements})$";

      lowopacity = [
        "caelestia-border-exclusion"
        "caelestia-drawers"
      ];

      highopacity = [
        "vicinae"
        "indicator"
        "logout_dialog"
        "verification"
      ];

      blurred = lib.concatLists [
        lowopacity
        highopacity
      ];
    in [
      "${toRegex blurred}, blur true"
      # "${toRegex lowopacity}, xray true"
      "${toRegex highopacity}, ignore_alpha 0.5,"
      "${toRegex lowopacity}, ignore_alpha 0.2"
    ];

    windowrule = let
      steamRegex = ids: let
        elements = lib.concatStringsSep "|" (map toString ids);
      in "match:class ^(steam_app_(${elements}))$";

      nativeRegex = classes: let
        elements = lib.concatStringsSep "|" classes;
      in "match:class ^(${elements})$";

      gamesOnSecondary = [
        1245620 # Elden Ring
      ];
      gamesCentered = [];

      nativeTearingGames = [
        "osu\\!"
        "cs2"
      ];
      # Regex for steam_app_<id> games only
      allSteamGames = "match:class ^(steam_app_[0-9]+)$";
      # Combined regex for any game (steam ID or native)
      anyGame = "match:class ^(steam_app_[0-9]+|${lib.concatStringsSep "|" nativeTearingGames})$";
    in [
      # INFO:
      # --- Workspace IDs ---
      # > Using split-monitor-workspaces with `enable_persistent_workspaces = true;`, the workspaces are labeled 1-20 with 10 workspaces/monitor.
      # DP-1: Workspaces 1-10
      # DP-2: Workspaces 11-20
      # > Setting a monitor with `monitor <ID>` is done for redundance, in case either the plugin is dropped or internal logic changes
      # ------

      # --- UI Elements & Utilities ---
      # Telegram media viewer
      "match:title ^(Media viewer)$, float on"
      # Bitwarden extension
      "match:title ^(.*Bitwarden Password Manager.*)$, float on"
      # Gnome calculator
      "match:class ^(org.gnome.Calculator)$, float on"
      "match:class ^(org.gnome.Calculator)$, size 360 490"

      # --- Web Browsers ---
      # Picture-in-Picture
      "match:title ^(Picture-in-Picture)$, float on"
      "match:title ^(Picture-in-Picture)$, pin on"
      # Sharing indicators (Special Workspace)
      "match:title ^(Firefox — Sharing Indicator)$, workspace special silent"
      "match:title ^(Zen — Sharing Indicator)$, workspace special silent"
      "match:title ^(.*is sharing (your screen|a window)\\.)$, workspace special silent"
      # File upload dialogs
      "match:class ^(zen)$, match:title ^(File Upload)$, dim_around on"

      # --- Media & Idle Inhibition ---
      # Video players
      # "match:class ^(mpv|.+exe|celluloid)$, idle_inhibit focus"
      # Browser media
      # "match:class ^(zen)$, match:title ^(.*YouTube.*)$, idle_inhibit focus"
      # "match:class ^(zen)$, idle_inhibit fullscreen"
      # Communication
      "match:class ^(vesktop)$, monitor DP-2"
      "match:class ^(vesktop)$, workspace 11"
      "match:class ^(vesktop)$, no_initial_focus on" # BUG: Not working
      # Music players
      "match:class ^(spotify)$, workspace 12"
      # "match:class ^(spotify)$, no_initial_focus on"

      # --- Dialogs & Authentication ---
      "match:class ^(gcr-prompter)$, dim_around on"
      "match:class ^(xdg-desktop-portal-gtk)$, dim_around on"
      "match:class ^(polkit-gnome-authentication-agent-1)$, dim_around on"

      # --- Development & IDEs ---
      # JetBrains popups
      "match:class ^(.*jetbrains.*)$, match:title ^(Confirm Exit|Open Project|win424|win201|splash)$, center on"
      "match:class ^(.*jetbrains.*)$, match:title ^(splash)$, size 640 400"

      # --- XWayland fixes ---
      # "match:xwayland true, rounding 0"

      # --- Global Styling ---
      # Disable hyprbars on tiled windows
      "match:float false, hyprbars:no_bar on"

      # --- Input & Scrolling Overrides ---
      # Browser-based
      "match:class ^(zen|firefox|chromium-browser|chrome-.*)$, scroll_touchpad 0.1"
      "match:class ^(obsidian)$, scroll_touchpad 0.1"
      # GTK / Productivity
      "match:class ^(com.github.xournalpp.xournalpp)$, scroll_touchpad 0.1"
      "match:class ^(libreoffice.*)$, scroll_touchpad 0.1"
      "match:class ^(.virt-manager-wrapped)$, scroll_touchpad 0.1"
      "match:class ^(xdg-desktop-portal-gtk)$, scroll_touchpad 0.1"
      # Qt / System
      "match:class ^(org.kde.kdeconnect.app)$, scroll_touchpad 0.1"
      "match:class ^(org.pwmt.zathura)$, scroll_touchpad 0.1"

      # --- Steam Client Rules ---
      "match:class ^(steam)$, workspace 4"
      "match:class ^(steam)$, monitor DP-1"
      "match:class ^(steam)$, immediate on"
      "match:class ^(steam)$, no_blur on"
      "match:class ^(steam)$, no_shadow on"
      # Fix initial sign in window position on startup
      "match:title ^(Sign in to Steam)$, float on"
      "match:title ^(Sign in to Steam)$, center on"
      # Tile friends list silently and adjust size
      "match:title ^(Friends List)$, tile on"
      "match:title ^(Friends List)$, size (monitor_w*0.12) (monitor_h*0.7)"
      "match:title ^(Friends List)$, min_size 300 400"
      "match:title ^(Friends List)$, max_size (monitor_w*0.3) (monitor_h*0.8)"
      "match:title ^(Friends List)$, no_initial_focus on" # BUG: Not working

      # --- Heroic Games Launcher ---
      "match:class ^(heroic)$, workspace 4"
      "match:class ^(heroic)$, monitor DP-1"
      "match:class ^(heroic)$, immediate on"
      "match:class ^(heroic)$, no_blur on"
      "match:class ^(heroic)$, no_shadow on"

      # --- Game Rules ---
      # TODO: Add rules for heroic launched games, if not always launched as `steam_app_*`

      # General defaults for all steam games
      "${anyGame}, workspace 5"
      "${anyGame}, monitor DP-1"
      "${anyGame}, fullscreen on"
      "${anyGame}, idle_inhibit focus"

      # Specific overrides for secondary
      "${steamRegex gamesOnSecondary}, monitor DP-2"

      # Specific overrides for centering on primary
      "${steamRegex gamesCentered}, monitor DP-1"
      "${steamRegex gamesCentered}, float on"
      "${steamRegex gamesCentered}, center on"
      "${steamRegex gamesCentered}, size 2560 1440"

      "${nativeRegex nativeTearingGames}, immediate on"
    ];
  };
}
