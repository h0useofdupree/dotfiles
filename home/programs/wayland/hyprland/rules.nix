{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    # layer rules
    layerrule = let
      toRegex = list: let
        elements = lib.concatStringsSep "|" list;
      in "^(${elements})$";

      lowopacity = [
        "bar"
        "calendar"
        "notifications"
        "system-menu"
      ];

      highopacity = [
        "anyrun"
        "osd"
        "logout_dialog"
      ];

      blurred = lib.concatLists [
        lowopacity
        highopacity
      ];
    in [
      "blur, ${toRegex blurred}"
      "xray 1, ${toRegex ["bar"]}"
      "ignorealpha 0.5, ${toRegex (highopacity ++ ["music"])}"
      "ignorealpha 0.2, ${toRegex lowopacity}"
      "blur, corner.*"
      "ignorealpha 0.6, corner.*"
    ];

    # TODO: windowrulev2 is deprecated, switch to windowrule when nix updates the syntax
    # window rules
    windowrulev2 = [
      # telegram media viewer
      "float, title:^(Media viewer)$"

      # Bitwarden extension
      "float, title:^(.*Bitwarden Password Manager.*)$"

      # gnome calculator
      "float, class:^(org.gnome.Calculator)$"
      "size 360 490, class:^(org.gnome.Calculator)$"

      # allow tearing in games
      # "immediate, class:^(osu\!|cs2)$"

      # make Firefox/Zen PiP window floating and sticky
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(Zen — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      # idle inhibit while watching videos
      "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
      "idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(zen)$"

      "dimaround, class:^(gcr-prompter)$"
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, class:^(polkit-gnome-authentication-agent-1)$"
      "dimaround, class:^(zen)$, title:^(File Upload)$"

      # fix xwayland apps
      #"rounding 0, xwayland:1"
      "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"

      # don't render hyprbars on tiling windows
      "plugin:hyprbars:nobar, floating:0"

      # less sensitive scroll for some windows
      # browser(-based)
      "scrolltouchpad 0.1, class:^(zen|firefox|chromium-browser|chrome-.*)$"
      "scrolltouchpad 0.1, class:^(obsidian)$"
      # GTK3
      "scrolltouchpad 0.1, class:^(com.github.xournalpp.xournalpp)$"
      "scrolltouchpad 0.1, class:^(libreoffice.*)$"
      "scrolltouchpad 0.1, class:^(.virt-manager-wrapped)$"
      "scrolltouchpad 0.1, class:^(xdg-desktop-portal-gtk)$"
      # Qt5
      "scrolltouchpad 0.1, class:^(org.kde.kdeconnect.app)$"
      # Others
      "scrolltouchpad 0.1, class:^(org.pwmt.zathura)$"
    ];
  };
}
