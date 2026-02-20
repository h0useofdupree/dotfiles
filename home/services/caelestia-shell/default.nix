{
  inputs,
  pkgs,
  lib,
  isLaptop,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  shellPkg = inputs.caelestia-shell.packages.${system}.default;
  quickshellPkg = inputs.quickshell.packages.${system}.default.override {
    withX11 = false;
    withI3 = false;
  };
  cliPkg = inputs.caelestia-cli.packages.${system}.default;
  # colorSyncPkg = inputs.self.packages.${system}.caelestia-colors;
  logging = lib.concatStringsSep ";" [
    "quickshell.dbus.properties.warning=false"
    "quickshell.dbus.dbusmenu.warning=false"
    "quickshell.service.notifications.warning=false"
    "quickshell.service.sni.host.warning=false"
    "qt.qpa.wayland.textinput.warning=false"
  ];
  mkThemeCommand = mode: [
    "sh"
    "-c"
    "caelestia scheme set -m ${mode} && ${lib.getExe pkgs.dconf} write /org/gnome/desktop/interface/gtk-theme \"'adw-gtk3-${mode}'\""
  ];
in {
  home.packages = [
    shellPkg
    quickshellPkg
    cliPkg
    # colorSyncPkg
  ];

  # TODO: Switch to hm module or rework how we handle the flake/shell.json config
  home.file.".config/caelestia/shell.json".text = builtins.toJSON {
    appearance = {
      anim.durations.scale = 1;
      font = {
        family = {
          material = "Material Symbols Rounded";
          mono = "MesloLGLDZ Nerd Font Mono";
          sans = "Inter";
          clock = "Inter";
        };
        size.scale = 1;
      };
      padding.scale = 1;
      rounding.scale = 1.2;
      spacing.scale = 1;
      transparency = {
        enabled = true;
        base = 0.5;
        layers = 0.4;
      };
    };
    general = {
      apps = {
        terminal = ["kitty"];
        audio = ["pwvucontrol"];
      };

      idle = {
        lockBeforeSleep = true;
        inhibitWhenAudio = true;
        timeouts =
          if isLaptop
          then [
            {
              timeout = 300; # 5 mins
              idleAction = "lock";
            }
            {
              timeout = 600; # 10 mins
              idleAction = "dpms off";
              returnAction = "dpms on";
            }
            {
              timeout = 900; # 15 mins
              idleAction = ["systemctl" "suspend"];
            }
          ]
          else [
            {
              timeout = 599; # 9:59 mins
              idleAction = "dpms off DP-2";
              returnAction = "dpms on DP-2";
            }
            {
              timeout = 600; # 10 mins
              idleAction = "lock";
            }
            {
              timeout = 1800; # 20 mins
              idleAction = "dpms off";
              returnAction = "dpms on";
            }
            {
              timeout = 3600; # 60 mins
              idleAction = ["systemctl" "suspend"];
            }
          ];
      };
    };
    background = {
      enabled = true;
      wallpaperEnabled = true;
      desktopClock = {
        enabled = true;
        scale = 1.5;
        position = "top-right";
        shadow = {
          enabled = true;
          opacity = 0.7;
          blur = 0.4;
        };
        background = {
          enabled = true;
          opacity = 0.3;
          blur = true;
        };
      };
      visualiser = {
        enabled = false;
        autoHide = true;
        rounding = 1;
        spacing = 1;
      };
    };
    bar = {
      entries = [
        {
          id = "logo";
          enabled = false;
        }
        {
          id = "workspaces";
          enabled = true;
        }
        {
          id = "spacer";
          enabled = true;
        }
        {
          id = "activeWindow";
          enabled = true;
        }
        {
          id = "spacer";
          enabled = true;
        }
        {
          id = "tray";
          enabled = true;
        }
        {
          id = "clock";
          enabled = true;
        }
        {
          id = "statusIcons";
          enabled = true;
        }
        {
          id = "idleInhibitor";
          enabled = true;
        }
        {
          id = "power";
          enabled = true;
        }
      ];
      dragThreshold = 20;
      persistent = true;
      showOnHover = true;
      workspaces = {
        activeIndicator = true;
        activeLabel = "󰮯 ";
        activeTrail = true;
        label = "  ";
        occupiedBg = true;
        occupiedLabel = "󰮯 ";
        perMonitorWorkspaces = true;
        showWindows = true;
        shown = 5;
      };
      status = {
        showAudio = true;
        showBattery = isLaptop;
        showBluetooth = true;
        showKbLayout = false;
        showMicrophone = false;
        showNetwork = true;
        showWifi = isLaptop;
        showLockStatus = true;
      };
      tray = {
        background = true;
        recolour = true;
      };
    };
    border = {
      rounding = 25;
      thickness = 10;
    };
    dashboard = {
      mediaUpdateInterval = 500;
    };
    launcher = {
      actionPrefix = "!";
      dragThreshold = 50;
      vimKeybinds = true;
      enableDangerousActions = true;
      maxShown =
        if isLaptop
        then 6
        else 10;
      maxWallpapers = 9;
      specialPrefix = "@";
      useFuzzy = {
        apps = true;
        actions = true;
        schemes = true;
        variants = true;
        wallpapers = true;
      };
      # TODO: Add favorites
      # favouriteApps = [
      # ];
      actions = [
        {
          name = "Calculator";
          icon = "calculate";
          description = "Do simple math equations (powered by Qalc)";
          command = ["autocomplete" "calc"];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Scheme";
          icon = "palette";
          description = "Change the current colour scheme";
          command = ["autocomplete" "scheme"];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Wallpaper";
          icon = "image";
          description = "Change the current wallpaper";
          command = ["autocomplete" "wallpaper"];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Variant";
          icon = "colors";
          description = "Change the current scheme variant";
          command = ["autocomplete" "variant"];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Transparency";
          icon = "opacity";
          description = "Change shell transparency";
          command = ["autocomplete" "transparency"];
          enabled = false;
          dangerous = false;
        }
        {
          name = "Random";
          icon = "casino";
          description = "Switch to a random wallpaper";
          command = ["caelestia" "wallpaper" "-r"];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Light";
          icon = "light_mode";
          description = "Change the scheme to light mode";
          # HACK: Use custom theme command to also set the gtk3 theme with dconf
          # command = ["setMode" "light"];
          command = mkThemeCommand "light";
          enabled = true;
          dangerous = false;
        }
        {
          name = "Dark";
          icon = "dark_mode";
          description = "Change the scheme to dark mode";
          # HACK: Use custom theme command to also set the gtk3 theme with dconf
          # command = ["setMode" "dark"];
          command = mkThemeCommand "dark";
          enabled = true;
          dangerous = false;
        }
        {
          name = "Shutdown";
          icon = "power_settings_new";
          description = "Shutdown the system";
          command = ["systemctl" "poweroff"];
          enabled = true;
          dangerous = true;
        }
        {
          name = "Reboot";
          icon = "cached";
          description = "Reboot the system";
          command = ["systemctl" "reboot"];
          enabled = true;
          dangerous = true;
        }
        {
          name = "Logout";
          icon = "exit_to_app";
          description = "Log out of the current session";
          command = ["loginctl" "terminate-user" ""];
          enabled = true;
          dangerous = true;
        }
        {
          name = "Lock";
          icon = "lock";
          description = "Lock the current session";
          command = ["loginctl" "lock-session"];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Sleep";
          icon = "bedtime";
          description = "Suspend then hibernate";
          command = ["systemctl" "suspend-then-hibernate"];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Settings";
          icon = "settings";
          description = "Configure the shell";
          command = ["caelestia" "shell" "controlCenter" "open"];
          enabled = true;
          dangerous = false;
        }
        {
          name = "KRK on";
          icon = "settings";
          description = "Turn on KRKs";
          command = ["speakerctl" "--on"];
          enabled = true;
          dangerous = false;
        }
        {
          name = "KRK off";
          icon = "settings";
          description = "Turn off KRKs";
          command = ["speakerctl" "--off"];
          enabled = true;
          dangerous = false;
        }
      ];
    };
    lock = {
      recolourLogo = true;
      maxNotifs =
        if isLaptop
        then 5
        else 8;
    };
    notifs = {
      actionOnClick = true;
      clearThreshold = 0.3;
      defaultExpireTimeout = 5000;
      expandThreshold = 20;
      expire = true;
    };
    osd = {
      enabled = true;
      enableBrightness = true;
      enableMicrophone = isLaptop;
      hideDelay = 2000;
    };
    paths = {
      mediaGif = "root:/assets/bongocat.gif";
      sessionGif = "root:/assets/kurukuru.gif";

      # NOTE: Needed for dynamic-wallpaper if not completely reworked!
      # wallpaperDir = config.home.homeDirectory + "/Pictures/WallpapersCache";
    };
    services = {
      weatherLocation = "51.12,7.4";
      useFahrenheit = false;
      useTwelveHourClock = false;
      audioIncrement = 0.05;
      brightnessIncrement = 0.1;
      smartScheme = true;
    };
    session = {
      enabled = true;
      dragThreshold = 30;
      vimKeybinds = true;
      commands = {
        logout = ["loginctl" "terminate-user" ""];
        shutdown = ["systemctl" "poweroff"];
        hibernate = ["systemctl" "suspend"];
        reboot = ["systemctl" "reboot"];
      };
    };
    sidebar = {
      enabled = true;
      dragThreshold = 80;
    };
    utilities = {
      enabled = true;
      maxToasts = 2;
      toasts = {
        audioInputChanged = true;
        audioOutputChanged = true;
        capsLockChanged = true;
        chargingChanged = isLaptop;
        configLoaded = true;
        dndChanged = true;
        gameModeChanged = true;
        kbLayoutChanged = true;
        kbLimit = true;
        numLockChanged = true;
        vpnChanged = true;
        nowPlaying = true;
      };
    };
    vpn = {
      enabled = false;
      # TODO: Add NordVPN with WireGuard
      # provider = [
      #   {
      #     name = "wireguard";
      #     interface = "your-connection-name";
      #     displayName = "Wireguard (Your VPN)";
      #     enabled = false;
      #   }
      # ];
    };
  };
  # Services
  systemd = {
    user = {
      services = {
        caelestia-shell = {
          Unit = {
            Description = "Caelestia desktop shell";
            After = ["graphical-session.target"];
          };
          Install.WantedBy = ["graphical-session.target"];
          Service = {
            ExecStart = lib.getExe shellPkg;
            Environment = "QT_LOGGING_RULES=${logging}";
            Restart = "on-failure";
          };
        };

        #   caelestia-colors = {
        #     Unit.Description = "Generate Hyprland colors from caelestia scheme";
        #     Service = {
        #       Type = "oneshot";
        #       ExecStart = lib.getExe colorSyncPkg;
        #     };
        #   };
        # };
        #
        # paths.caelestia-colors = {
        #   Unit.Description = "Watch caelestia scheme for changes";
        #   Path = {
        #     PathModified = config.home.homeDirectory + "/.local/state/caelestia/scheme.json";
        #     Unit = "caelestia-colors.service";
        #   };
        #   Install.WantedBy = ["graphical-session.target"];
      };
    };
  };
  # systemd.user.services.caelestia-lock-once = {
  #   Unit = {
  #     Description = "Lock screen once after Caelestia shell is ready";
  #     After = ["graphical-session.target" "caelestia-shell.service"];
  #     Wants = ["caelestia-shell.service"];
  #   };
  #   Service = {
  #     Type = "oneshot";
  #     # tiny retry loop to avoid races without ugly sleeps
  #     ExecStart = let
  #       script =
  #         pkgs.writeShellScript "caelestia-lock-once"
  #         ''
  #           set -euo pipefail
  #           for i in $(seq 1 150); do
  #             if ${lib.getExe cliPkg} shell lock lock >/dev/null 2>&1; then
  #               exit 0
  #             fi
  #             sleep 0.1
  #           done
  #           echo "caelestia lock: shell not ready after 15s, giving up" >&2
  #           exit 1
  #         '';
  #     in
  #       script;
  #     # Optional: cleaner logs
  #     Environment = "PATH=${lib.makeBinPath [pkgs.coreutils cliPkg]}";
  #   };
  #   Install.WantedBy = ["graphical-session.target"];
  # };
}
