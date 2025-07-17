{
  isLaptop,
  lib,
  pkgs,
  ...
}: let
  rightModules =
    [
      "volume"
      "bluetooth"
      "network"
    ]
    ++ lib.optional isLaptop "battery"
    ++ [
      "systray"
      "notifications"
      "clock"
    ];
  middleModules = [
    "windowtitle"
  ];
  leftModules = [
    "dashboard"
    "workspaces"
    "media"
  ];

  clockFormat = "%a %b %d %H:%M";
in {
  programs.hyprpanel = {
    enable = true;
    systemd.enable = false;

    settings = {
      tear = true;
      bar = {
        layouts = {
          "*" = {
            left = leftModules;
            middle = middleModules;
            right = rightModules;
          };
        };

        clock.format = clockFormat;
        customModules = {
          cava = {
            showIcon = false;
            showActiveOnly = true;
          };
        };
        launcher.icon = "";
        # TODO: Find out where to put these
        shadow = "0px 0px 0px 0px #16161e";
        shadowMargins = "10px 10px";
      };

      menus = {
        clock = {
          time.hideSeconds = false;
          weather = {
            enabled = true;
            location = "Mettmann";
            unit = "metric";
            key = "9369646bb99b447dbdf114945251607";
          };
        };

        dashboard = {
          # "menus.dashboard.powermenu.avatar.image" = "/home/h0useofdupree/.cache/dynamic-wallpaper/current"; # Use default: ~/.face.icon
          # TODO: Encrypt ~/.face.icon with age(nix) and add to repo
          shortcuts.enabled = true;
          stats = {
            enabled = true;
            enable_gpu = false;
            interval = 2000;
          };
        };
      };

      wallpaper = {
        enable = false;
        # Choose image for matugen
        image = "/home/h0useofdupree/.cache/dynamic-wallpaper/current";
      };
      theme = {
        matugen = true;
        matugen_settings = {
          mode = "dark";
          scheme_type = "monochrome";
          variation = "standard_1";
        };
        bar = {
          border_radius = "1.0em";
          buttons = {
            enableBorders = false;
            radius = "0.85em";
            spacing = "0.3em";
            padding_x = "1.0em";
            background_opacity = "0";
          };
          floating = true;
          location = "top";
          margin_sides = "1.5em";
          menus = {
            border.radius = "1.5em";
            card_radius = "1.5em";
            popover.radius = "1.5em";
            opacity = "60";
          };
          opacity = "100";
          outer_spacing = "0.5em";
          transparent = false;
          workspaces.showApplicationIcons = true;
        };
        osd = {
          location = "top";
          orientation = "horizontal";
        };
      };
    };
  };

  systemd.user.services.hyprpanel = {
    Unit = {
      Description = "Custom Hyprpanel Service";
      After = ["hyprland-session.target"];
      PartOf = ["graphical-session.target"];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };

    Service = {
      Type = "simple";

      # Wait until hyprland reports monitors
      ExecStartPre = pkgs.writeShellScript "wait-for-hyprland" ''
        export PATH=${pkgs.hyprland}/bin:${pkgs.coreutils}/bin:${pkgs.gnugrep}/bin:${pkgs.findutils}/bin:$PATH

        echo "Waiting for HYPRLAND_INSTANCE_SIGNATURE..."
        while [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; do
          sleep 0.2
        done

        echo "Waiting for at least one monitor..."
        while ! hyprctl monitors | grep -q "^Monitor .* (ID [0-9]\+):"; do
          sleep 0.2
        done

        echo "Monitors detected, starting Hyprpanel..."
      '';

      ExecStart = "${pkgs.hyprpanel}/bin/hyprpanel";
      ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
      Restart = "always";
      RestartSec = 2;
      KillMode = "mixed";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
