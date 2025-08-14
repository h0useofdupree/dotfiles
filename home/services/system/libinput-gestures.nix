{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libinput-gestures
    wl-clipboard
    wtype
    wireplumber
    playerctl
  ];

  xdg.configFile."libinput-gestures.conf".text = ''
    # Either make larger increments or use entirely different commands.
    gesture swipe left 4 ${pkgs.hyprland}/bin/hyprctl dispatch exec "${pkgs.playerctl}/bin/playerctl previous"
    gesture swipe right 4 ${pkgs.hyprland}/bin/hyprctl dispatch exec "${pkgs.playerctl}/bin/playerctl next"
    gesture swipe up 4 ${pkgs.hyprland}/bin/hyprctl dispatch exec "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%+"
    gesture swipe down 4 ${pkgs.hyprland}/bin/hyprctl dispatch exec "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%-"

    # Browser control
    gesture swipe left_down 4 ${pkgs.hyprland}/bin/hyprctl dispatch exec "${pkgs.wtype}/bin/wtype -M ctrl w -m ctrl"
    gesture swipe right_down 4 ${pkgs.hyprland}/bin/hyprctl dispatch exec "${pkgs.wtype}/bin/wtype -M ctrl t -m ctrl"

    gesture pinch in   4 ${pkgs.hyprland}/bin/hyprctl dispatch exec "caelestia shell lock lock"

    # Screenshots
    gesture swipe left_up  4 ${pkgs.hyprland}/bin/hyprctl dispatch exec "caelestia shell picker openFreeze"
    gesture swipe right_up  4 ${pkgs.hyprland}/bin/hyprctl dispatch exec "caelestia screenshot"

    gesture hold on 4 ${pkgs.hyprland}/bin/hyprctl dispatch global caelestia:session
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
