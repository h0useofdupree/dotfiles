{
  config,
  inputs,
  pkgs,
  lib,
  isLaptop,
  ...
}: let
  shellPkg = inputs.caelestia-shell.packages.${pkgs.system}.default;
  quickshellPkg = inputs.quickshell.packages.${pkgs.system}.default.override {
    withX11 = false;
    withI3 = false;
  };
  cliPkg = inputs.caelestia-cli.packages.${pkgs.system}.default;
  logging = lib.concatStringsSep ";" [
    "quickshell.dbus.properties.warning=false"
    "quickshell.dbus.dbusmenu.warning=false"
    "quickshell.service.notifications.warning=false"
    "quickshell.service.sni.host.warning=false"
    "qt.qpa.wayland.textinput.warning=false"
  ];
in {
  home.packages = [
    shellPkg
    quickshellPkg
    cliPkg
  ];

  home.file.".config/caelestia/shell.json".text = builtins.toJSON {
    general = {
      apps = {
        terminal = ["kitty"];
        audio = ["pwvucontrol"];
      };
    };
    background = {
      enabled = false;
      desktopClock = true;
    };
    bar = {
      dragThreshold = 20;
      persistent = true;
      showOnHover = true;
      workspaces = {
        activeIndicator = true;
        activeLabel = "󰮯 ";
        activeTrail = true;
        label = "  ";
        occupiedBg = false;
        occupiedLabel = "󰮯 ";
        rounded = true;
        showWindows = true;
        shown = 5;
      };
      status = {
        showAudio = !isLaptop;
        showBattery = isLaptop;
        showNetwork = isLaptop;
      };
    };
    border = {
      rounding = 25;
      thickness = 10;
    };
    dashboard = {
      mediaUpdateInterval = 500;
      visualiserBars = 45;
    };
    launcher = {
      actionPrefix = ">";
      dragThreshold = 50;
      vimKeybinds = true;
      enableDangerousActions = false;
      maxShown = 8;
      maxWallpapers = 9;
      useFuzzy = {
        apps = false;
        actions = false;
        schemes = false;
        variants = false;
        wallpapers = true;
      };
    };
    lock = {
      maxNotifs = 5;
    };
    notifs = {
      actionOnClick = true;
      clearThreshold = 0.3;
      defaultExpireTimeout = 5000;
      expandThreshold = 20;
      expire = true;
    };
    osd = {
      hideDelay = 2000;
    };
    paths = {
      mediaGif = "root:/assets/bongocat.gif";
      sessionGif = "root:/assets/kurukuru.gif";
      wallpaperDir = config.home.homeDirectory + "/Pictures/WallpapersCache";
    };
    services = {
      weatherLocation = "51.24,6.95";
      useFahrenheit = false;
    };
    session = {
      dragThreshold = 30;
      vimKeybinds = true;
      commands = {
        logout = ["loginctl" "terminate-user" ""];
        shutdown = ["systemctl" "poweroff"];
        hibernate = ["systemctl" "suspend"];
        reboot = ["systemctl" "reboot"];
      };
    };
  };

  systemd.user.services.caelestia-shell = {
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
}
