{
  services.gammastep = {
    enable = true;
    tray = true;

    provider = "manual";
    latitude = 51.1;
    longitude = 7.3;

    enableVerboseLogging = true;

    settings.general.adjustment-method = "wayland";
  };
}
