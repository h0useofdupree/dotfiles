{
  services.gammastep = {
    enable = true;
    tray = true;

    provider = "manual";
    latitude = 51.2;
    longitude = 6.9;

    enableVerboseLogging = true;

    settings.general.adjustment-method = "wayland";
  };
}
