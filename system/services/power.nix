# Laptop only
{
  services = {
    logind.settings.Login.HandlePowerKey = "suspend-then-hibernate";

    power-profiles-daemon.enable = true;

    upower.enable = true;
  };
}
