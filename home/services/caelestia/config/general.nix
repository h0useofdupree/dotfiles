{isLaptop}: {
  general = {
    apps = {
      terminal = ["kitty"];
      audio = ["pwvucontrol"];
    };

    idle = {
      # BUG: DPMS currently broken on hyprland with quickshell
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
            idleAction = "caelestia shell brightness set 0";
            returnAction = "caelestia shell brightness set 1";
          }
          {
            timeout = 900; # 15 mins
            idleAction = ["systemctl" "suspend"];
          }
        ]
        else [
          {
            timeout = 600; # 10 mins
            idleAction = "lock";
          }
          {
            timeout = 1800; # 20 mins
            idleAction = "caelestia shell brightness set 0";
            returnAction = "caelestia shell brightness set 1";
          }
          {
            timeout = 3600; # 60 mins
            idleAction = ["systemctl" "suspend"];
          }
        ];
    };
  };
}
