{
  config,
  lib,
  pkgs,
  ...
}: let
  themeScript = theme:
    pkgs.writeShellScript "theme-start-${theme}"
    /*
    bash
    */
    ''
      set -euo pipefail

      # GTK4/libadwaita preference
      ${lib.getExe pkgs.dconf} write /org/gnome/desktop/interface/color-scheme "'prefer-${theme}'"

      # GTK3 theme name
      # NOTE: Added specifically for zen. Don't know if needed elsewhere.
      ${lib.getExe pkgs.dconf} write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3-${theme}'"

      cat <<EOF > ${config.xdg.configHome}/Kvantum/kvantum.kvconfig
      [General]
      theme=KvLibadwaita${lib.optionalString (theme == "dark") "Dark"}
      EOF
    '';
in {
  systemd.user.timers = {
    theme-toggle-dark = {
      Unit.Description = "Toggle dark theme";
      Timer = {
        OnCalendar = [
          "*-*-* 17:00:00"
        ];
        Persistent = true;
      };
      Timer.Unit = "theme-toggle-dark.service";
      Install.WantedBy = ["graphical-session.target"];
    };

    theme-toggle-light = {
      Unit.Description = "Toggle light theme";
      Timer = {
        OnCalendar = [
          "*-*-* 07:00:00"
        ];
        Persistent = true;
      };
      Timer.Unit = "theme-toggle-light.service";
      Install.WantedBy = ["graphical-session.target"];
    };
  };

  systemd.user.services = {
    theme-toggle-dark = {
      Unit.Description = "Toggle dark theme";
      Service = {
        Type = "oneshot";
        ExecStart = themeScript "dark";
        TimeoutStopSec = 5;
      };
    };
    theme-toggle-light = {
      Unit.Description = "Toggle light theme";
      Service = {
        Type = "oneshot";
        ExecStart = themeScript "light";
        TimeoutStopSec = 5;
      };
    };
  };
}
