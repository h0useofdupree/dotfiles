{pkgs, ...}: {
  home.packages = [pkgs.speaker-test];
  systemd = {
    user = {
      services.krk-keep-awake = {
        Unit = {
          Description = "KRK Keep Awake Pulse";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.speaker-test}/bin/speaker-test -t sine -f 10 -l 1 -p 2000";
        };
        Install = {
          WantedBy = ["default.target"];
        };
      };

      timers.krk-keep-awake = {
        Unit = {
          Description = "KRK Keep Awake Timer";
        };
        Timer = {
          OnBootSec = "1min";
          OnUnitActiveSec = "25min";
          Persistent = true;
        };
        Install = {
          WantedBy = ["timers.target"];
        };
      };
    };
  };
}
