{pkgs, ...}: {
  services = {
    # Allow GNOME services outside of GNOME-DE
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];

    gnome.gnome-keyring.enable = true;

    gvfs.enable = true;
    tumbler.enable = true;
  };
}
