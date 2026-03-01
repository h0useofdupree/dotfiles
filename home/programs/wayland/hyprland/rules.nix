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
      "match:class ^(mpv|.+exe|celluloid)$, idle_inhibit focus"
      # Browser media
      "match:class ^(zen)$, match:title ^(.*YouTube.*)$, idle_inhibit focus"
      "match:class ^(zen)$, idle_inhibit fullscreen"

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
      "match:class ^(steam)$, workspace 9"
      "match:class ^(steam)$, monitor DP-1"
      "match:class ^(steam)$, immediate on"
      "match:class ^(steam)$, no_blur on"
      "match:class ^(steam)$, no_shadow on"

      # --- Game Rules ---
      # General defaults for all steam games
      "${anyGame}, workspace 10"
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
