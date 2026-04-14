{isLaptop}: {
  general = {
    apps = {
      terminal = ["kitty"];
      audio = ["pwvucontrol"];
    };

    idle = {
      # TODO: DPMS fixed upstream in Hyprland 0.54.3 apparently. Use dpms again after update
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
            # idleAction = "dpms off";
            # returnAction = "dpms on";
          }
          {
            timeout = 900; # 15 mins
            # TODO: Add swap/zram for linx
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
            # idleAction = "dpms off";
            # returnAction = "dpms on";
          }
          {
            timeout = 3600; # 60 mins
            idleAction = ["systemctl" "suspend-then-hibernate"];
          }
        ];
    };
  };
}
