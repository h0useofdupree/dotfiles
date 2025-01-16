{
  services = {
    dbus.implementation = "broker";

    # profile-sync-daemon
    psd = {
      enable = true;
      # NOTE: Change this to lower values, if feasable, to reduce risk of data loss when system crashes
      resyncTimer = "10m";
    };
  };
}
