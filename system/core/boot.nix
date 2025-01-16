{
  pkgs,
  config,
  ...
}: {
  boot = {
    initrd = {
      systemd.enable = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
      #systemd-boot.enable = false;
    };

    plymouth.enable = false;
  };

  environment.systemPackages = [config.boot.kernelPackages.cpupower];
}
