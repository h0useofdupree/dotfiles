{pkgs, ...}: {
  networking = {
    # nameservers = {};
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };
  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };
  };
}
