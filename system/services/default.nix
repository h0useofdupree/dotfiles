{pkgs, ...}: {
  services = {
    dbus.implementation = "broker";

    # profile-sync-daemon
    psd = {
      enable = true;
      # NOTE: Change this to lower values, if feasable, to reduce risk of data loss when system crashes
      resyncTimer = "10m";
    };
  };

  # Use in place of hypridle's before_sleep_cmd, since systemd does not wait for
  # it to complete
  systemd.services.before-sleep = let
    suspendScript = pkgs.writeShellScript "suspend-script" ''
      # Lock all sessions
      loginctl lock-sessions

      # Wait for lockscreen
      sleep 3
    '';
  in {
    requiredBy = ["sleep.target"];
    partOf = ["sleep.target"];
    description = "Commands run before sleep";

    serviceConfig = {
      ExecStart = suspendScript.outPath;
      Type = "oneshot";
    };
  };
}
