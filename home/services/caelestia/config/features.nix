{
  config,
  isLaptop,
}: {
  background = {
    enabled = true;
    wallpaperEnabled = true;
    desktopClock = {
      enabled = true;
      scale = 1.5;
      position = "bottom-right";
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
      invertColors = false;
    };
    visualiser = {
      enabled = false;
      autoHide = true;
      rounding = 1;
      spacing = 1;
    };
  };

  border = {
    rounding = 25;
    thickness = 10;
  };

  dashboard = {
    mediaUpdateInterval = 500;
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
    defaultExpireTimeout = 4000;
    expandThreshold = 20;
    expire = true;
  };

  osd = {
    enabled = true;
    enableBrightness = true;
    enableMicrophone = !isLaptop;
    hideDelay = 2000;
  };

  paths = {
    mediaGif = "root:/assets/bongocat.gif";
    sessionGif = "root:/assets/kurukuru.gif";
    lyricsDir = "~/Music/lyrics";
    # wallpaperDir = config.home.homeDirectory + "/Pictures/WallpapersCache";
  };

  services = {
    weatherLocation = "51.25278, 6.97778";
    useFahrenheit = false;
    useTwelveHourClock = false;
    audioIncrement = 0.05;
    brightnessIncrement = 0.1;
    smartScheme = false;
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
    icons = {
      logout = "logout";
      shutdown = "power_settings_new";
      hibernate = "bedtime";
      reboot = "cached";
    };
  };

  sidebar = {
    enabled = true;
    dragThreshold = 80;
  };

  utilities = {
    enabled = true;
    maxToasts =
      if isLaptop
      then 1
      else 2;
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
      nowPlaying = false;
    };
  };

  vpn = {
    enabled = true;
    provider = [
      {
        name = "wireguard";
        enabled = true;
        interface = "nordvpn";
        displayName = "NordVPN";
        connectCmd = ["pkexec" "systemctl" "start" "wg-quick-nordvpn"];
        disconnectCmd = ["pkexec" "systemctl" "stop" "wg-quick-nordvpn"];
      }
    ];
  };

  quicktoggles = [
    {
      id = "wifi";
      enabled = true;
    }
    {
      id = "bluetooth";
      enabled = true;
    }
    {
      id = "mic";
      enabled = true;
    }
    {
      id = "settings";
      enabled = true;
    }
    {
      id = "gameMode";
      enabled = true;
    }
    {
      id = "dnd";
      enabled = true;
    }
    {
      id = "vpn";
      enabled = true;
    }
  ];
}
