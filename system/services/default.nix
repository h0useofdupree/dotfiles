{pkgs, ...}: {
  services = {
    dbus.implementation = "broker";

    udisks2.enable = true;

    # profile-sync-daemon
    psd = {
      enable = true;
      # NOTE: Change this to lower values, if feasable, to reduce risk of data loss when system crashes
      resyncTimer = "10m";
    };

    ollama = {
      enable = true;
      # acceleration = "rocm";
    };
  };

  # Use in place of hypridle's before_sleep_cmd, since systemd does not wait for
  # it to complete
  powerManagement = {
    enable = true;
    powerDownCommands = ''
      # Lock all sessions
      loginctl lock-sessions

      # Wait for lockscreen
      sleep 1
    '';
  };
}
