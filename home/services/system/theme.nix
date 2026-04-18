{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.theme.auto) darkTime enable lightTime;

  themeApply = pkgs.writeShellScript "theme-apply" ''
    set -euo pipefail

    mode="''${1:-auto}"
    now="''${THEME_NOW:-$(${pkgs.coreutils}/bin/date +%H:%M)}"
    kvantum_dir="${config.xdg.configHome}/Kvantum"
    kvantum_config="$kvantum_dir/kvantum.kvconfig"

    find_caelestia() {
      local candidate

      for candidate in \
        "/etc/profiles/per-user/${config.home.username}/bin/caelestia" \
        "${config.home.homeDirectory}/.nix-profile/bin/caelestia"
      do
        if [[ -x "$candidate" ]]; then
          printf '%s\n' "$candidate"
          return 0
        fi
      done

      if candidate="$(${pkgs.coreutils}/bin/env PATH="$PATH" ${pkgs.bash}/bin/bash -lc 'command -v caelestia' 2>/dev/null)"; then
        if [[ -n "$candidate" && -x "$candidate" ]]; then
          printf '%s\n' "$candidate"
          return 0
        fi
      fi

      echo "Could not find the 'caelestia' executable" >&2
      exit 127
    }

    caelestia="$(find_caelestia)"

    to_minutes() {
      local time="$1"
      local hour minute

      if [[ ! "$time" =~ ^([0-9]{2}):([0-9]{2})$ ]]; then
        echo "Invalid time format: $time" >&2
        exit 1
      fi

      hour="''${BASH_REMATCH[1]}"
      minute="''${BASH_REMATCH[2]}"

      if ((10#$hour > 23 || 10#$minute > 59)); then
        echo "Invalid time value: $time" >&2
        exit 1
      fi

      echo $((10#$hour * 60 + 10#$minute))
    }

    if [[ "$mode" == "auto" ]]; then
      now_minutes="$(to_minutes "$now")"
      light_minutes="$(to_minutes "${lightTime}")"
      dark_minutes="$(to_minutes "${darkTime}")"

      if ((light_minutes == dark_minutes)); then
        echo "theme.auto.lightTime and theme.auto.darkTime must not match" >&2
        exit 1
      fi

      if ((light_minutes < dark_minutes)); then
        if ((now_minutes >= light_minutes && now_minutes < dark_minutes)); then
          mode="light"
        else
          mode="dark"
        fi
      else
        if ((now_minutes >= dark_minutes && now_minutes < light_minutes)); then
          mode="dark"
        else
          mode="light"
        fi
      fi
    fi

    case "$mode" in
      dark)
        gtk_theme="adw-gtk3-dark"
        kvantum_theme="KvLibadwaitaDark"
        ;;
      light)
        gtk_theme="adw-gtk3-light"
        kvantum_theme="KvLibadwaita"
        ;;
      *)
        echo "Unsupported theme mode: $mode" >&2
        exit 1
        ;;
    esac

    "$caelestia" scheme set -m "$mode"
    ${lib.getExe pkgs.dconf} write /org/gnome/desktop/interface/color-scheme "'prefer-$mode'"
    ${lib.getExe pkgs.dconf} write /org/gnome/desktop/interface/gtk-theme "'$gtk_theme'"

    ${pkgs.coreutils}/bin/mkdir -p "$kvantum_dir"
    cat <<EOF > "$kvantum_config"
    [General]
    theme=$kvantum_theme
    EOF
  '';
in {
  systemd.user.services =
    {
      theme-set-dark = {
        Unit.Description = "Apply dark theme";
        Service = {
          Type = "oneshot";
          ExecStart = "${themeApply} dark";
          TimeoutStopSec = 5;
        };
      };

      theme-set-light = {
        Unit.Description = "Apply light theme";
        Service = {
          Type = "oneshot";
          ExecStart = "${themeApply} light";
          TimeoutStopSec = 5;
        };
      };
    }
    // lib.optionalAttrs enable {
      theme-sync-auto = {
        Unit.Description = "Apply automatic theme for the current time";
        Install.WantedBy = ["graphical-session.target"];
        Service = {
          Type = "oneshot";
          ExecStart = "${themeApply} auto";
          TimeoutStopSec = 5;
        };
      };
    };

  systemd.user.timers = lib.optionalAttrs enable {
    theme-auto-dark = {
      Unit.Description = "Apply dark theme on schedule";
      Timer = {
        OnCalendar = ["*-*-* ${darkTime}:00"];
        Persistent = true;
      };
      Timer.Unit = "theme-set-dark.service";
      Install.WantedBy = ["timers.target"];
    };

    theme-auto-light = {
      Unit.Description = "Apply light theme on schedule";
      Timer = {
        OnCalendar = ["*-*-* ${lightTime}:00"];
        Persistent = true;
      };
      Timer.Unit = "theme-set-light.service";
      Install.WantedBy = ["timers.target"];
    };
  };
}
