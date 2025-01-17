{
  services = {
    logind.powerKey = "suspend";

    power-profiles-daemon.enable = true;

    upower.enable = true;

    #udev.extraRules = ''
    #  ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
    #'';
  };
}
