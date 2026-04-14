{
  pkgs,
  lib,
  self,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];
  age = {
    secrets = {
      speakerctl-devices = {
        file = "${self}/secrets/speakerctl-devices.age";
        owner = "h0useofdupree";
        group = "users";
      };

      spotify-client-id = {
        file = "${self}/secrets/spotify-client-id.age";
        owner = "h0useofdupree";
        group = "users";
      };

      openai-api-key = {
        file = "${self}/secrets/openai-api-key.age";
        owner = "h0useofdupree";
        group = "users";
      };

      nordvpn-private-key = {
        file = "${self}/secrets/nordvpn-private-key.age";
        owner = "h0useofdupree";
        group = "users";
      };

      #weatherapi-key = {
      #   file = "${self}/secrets/weatherapi-key.age";
      #   owner = "h0useofdupree";
      #   group = "users";
      # };
    };
  };

  networking.hostName = "nixus";

  services = {
    fstrim.enable = true;

    # Disable wakeup from AMD USB-Controller
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1022" ATTR{device}=="0x43f7" ATTR{power/wakeup}="disabled"
      KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
    '';

    displayManager.gdm.enable = false;
    desktopManager.gnome.enable = false;

    xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
    priority = 100;
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      priority = 10;
    }
  ];

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/6680d70d-e9cd-42b9-bce1-a5effa035fc7";
    fsType = "btrfs";
    options = ["subvol=@swap" "noatime"];
  };

  systemd.sleep.settings.Sleep = {
    AllowSuspend = true;
    AllowHibernation = true;
    AllowSuspendThenHibernate = true;
    AllowHybridSleep = false;
    HibernateDelaySec = "1h";
  };

  # Extra packages
  environment.systemPackages = with pkgs; [
    clinfo
  ];

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;
    initrd.kernelModules = ["amdgpu"];
    kernelModules = ["i2c-dev" "i2c-piix4"];
    kernelParams = [
      "acpi_enforce_resources=lax"
      "resume_offset=31749371"
    ];
    resumeDevice = "/dev/disk/by-uuid/6680d70d-e9cd-42b9-bce1-a5effa035fc7";
  };
  users = {
    groups.i2c = {};
    users.h0useofdupree.extraGroups = ["i2c"];
  };
  # Set user preferences for environment variables
  environment.variables = {
    LC_TIME = "de_DE.UTF-8"; # Time format
    LC_NUMERIC = "de_DE.UTF-8"; # Numeric format
    LC_MONETARY = "de_DE.UTF-8"; # Currency
    LC_MEASUREMENT = "de_DE.UTF-8"; # Units (e.g., metric)
    LANG = "en_US.UTF-8"; # Interface language
    NH_FLAKE = "/home/h0useofdupree/.dotfiles";
    OPENAI_API_KEY = "$(${pkgs.coreutils}/bin/cat ${config.age.secrets.openai-api-key.path})";
  };
}
