{
  services.gammastep = {
    enable = true;
    tray = true;

    provider = "geoclue2";

    #NOTE: Fallback
    latitude = 51.2;
    longitude = 6.9;

    temperature = {
      day = 6000;
      night = 3700;
    };

    enableVerboseLogging = true;

    settings.general.adjustment-method = "wayland";
  };
}
