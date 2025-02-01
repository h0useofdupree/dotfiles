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

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "plymouth.use-simpledrm"
      "video=3440x1440"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      # timeout = 0;

      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
      systemd-boot.enable = false;
    };

    plymouth = {
      enable = false;
      theme = "rings";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["rings"];
        })
      ];
    };
  };

  environment.systemPackages = [config.boot.kernelPackages.cpupower];
}
