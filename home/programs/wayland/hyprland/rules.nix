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

    windowrule = [
      # telegram media viewer
      "match:title ^(Media viewer)$, float on"

      # Bitwarden extension
      "match:title ^(.*Bitwarden Password Manager.*)$, float on"

      # gnome calculator
      "match:class ^(org.gnome.Calculator)$, float on"
      "match:class ^(org.gnome.Calculator)$, size 360 490"

      # allow tearing in games
      # "match:class ^(osu\\!|cs2)$, immediate on"

      # make Firefox/Zen PiP window floating and sticky
      "match:title ^(Picture-in-Picture)$, float on"
      "match:title ^(Picture-in-Picture)$, pin on"

      # throw sharing indicators away
      "match:title ^(Firefox — Sharing Indicator)$, workspace special silent"
      "match:title ^(Zen — Sharing Indicator)$, workspace special silent"
      "match:title ^(.*is sharing (your screen|a window)\\.)$, workspace special silent"

      # idle inhibit while watching videos
      "match:class ^(mpv|.+exe|celluloid)$, idle_inhibit focus"
      "match:class ^(zen)$, match:title ^(.*YouTube.*)$, idle_inhibit focus"
      "match:class ^(zen)$, idle_inhibit fullscreen"

      "match:class ^(gcr-prompter)$, dim_around on"
      "match:class ^(xdg-desktop-portal-gtk)$, dim_around on"
      "match:class ^(polkit-gnome-authentication-agent-1)$, dim_around on"
      "match:class ^(zen)$, match:title ^(File Upload)$, dim_around on"

      # fix xwayland apps
      # "match:xwayland true, rounding 0"
      "match:class ^(.*jetbrains.*)$, match:title ^(Confirm Exit|Open Project|win424|win201|splash)$, center on"
      "match:class ^(.*jetbrains.*)$, match:title ^(splash)$, size 640 400"

      # don't render hyprbars on tiling windows
      "match:float true, hyprbars:no_bar on"

      # less sensitive scroll for some windows
      # browser(-based)
      "match:class ^(zen|firefox|chromium-browser|chrome-.*)$, scroll_touchpad 0.1"
      "match:class ^(obsidian)$, scroll_touchpad 0.1"
      # GTK3
      "match:class ^(com.github.xournalpp.xournalpp)$, scroll_touchpad 0.1"
      "match:class ^(libreoffice.*)$, scroll_touchpad 0.1"
      "match:class ^(.virt-manager-wrapped)$, scroll_touchpad 0.1"
      "match:class ^(xdg-desktop-portal-gtk)$, scroll_touchpad 0.1"
      # Qt5
      "match:class ^(org.kde.kdeconnect.app)$, scroll_touchpad 0.1"
      # Others
      "match:class ^(org.pwmt.zathura)$, scroll_touchpad 0.1"
    ];
  };
}
