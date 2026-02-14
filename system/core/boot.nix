{
  pkgs,
  config,
  inputs,
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
      "video=DP-1:3440x1440@160"
      "video=DP-2:2560x1440@180"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      # timeout = 0;

      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        # theme = inputs.grub-themes.packages.${pkgs.system}.hyperfluent;
        theme = "${inputs.elegant-grub.packages.${pkgs.stdenv.hostPlatform.system}.wave-right-dark-4k}/theme";
      };
      systemd-boot.enable = false;
    };

    plymouth = {
      enable = true;
      theme = "cuts";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["cuts"];
        })
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    config.boot.kernelPackages.cpupower
    os-prober
  ];
}
