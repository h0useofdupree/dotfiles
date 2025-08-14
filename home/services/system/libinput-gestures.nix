{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libinput-gestures
    wl-clipboard
    wtype
    playerctl
  ];

  xdg.configFile."libinput-gestures.conf".text = ''
    gesture swipe left  4 /run/current-system/sw/bin/hyprctl dispatch resizeactive -60 0
    gesture swipe right 4 /run/current-system/sw/bin/hyprctl dispatch resizeactive  60 0
    gesture swipe up    4 /run/current-system/sw/bin/hyprctl dispatch resizeactive  0 -60
    gesture swipe down  4 /run/current-system/sw/bin/hyprctl dispatch resizeactive  0  60

    gesture pinch in   4 /run/current-system/sw/bin/hyprctl dispatch exec "caelestia shell lock lock"

    gesture pinch out  4 /run/current-system/sw/bin/hyprctl dispatch exec "caelestia shell picker openFreeze"

    gesture pinch in   5 /run/current-system/sw/bin/hyprctl dispatch global caelestia:session
    # gesture pinch in 4 /run/current-system/sw/bin/hyprctl dispatch global caelestia:session

    gesture pinch out  5 /run/current-system/sw/bin/hyprctl dispatch global caelestia:showAll
    # (Uncomment the 4-finger version below if your pad only reports up to 4 fingers)
    # gesture pinch out 4 /run/current-system/sw/bin/hyprctl dispatch global caelestia:showAll

    # --- Tips ---
    # 1) After editing, reload:  libinput-gestures -r
    # 2) If directions feel backwards, swap the +/- in the resize lines.
    # 3) If commands don’t trigger, run them manually to check PATH. We invoke via hyprctl
    #    to avoid PATH issues since libinput-gestures doesn’t run commands under a shell.
  '';

  systemd.user.services.libinput-gestures = {
    Unit = {
      Description = "Touchpad gestures daemon";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures -c ${config.xdg.configHome}/libinput-gestures.conf";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
