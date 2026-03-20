{config, ...}: {
  networking = {
    # nameservers = {};
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
    wg-quick.interfaces = {
      nordvpn = {
        autostart = false;
        address = ["10.5.0.2/32"];
        dns = ["103.86.96.100" "103.86.99.100"];

        privateKeyFile = config.age.secrets.nordvpn-private-key.path;

        peers = [
          {
            publicKey = "m0tej5P6pYfBivkJc8yRV4KqQXmM81AChLlzlsOSjSs=";
            endpoint = "de1188.nordvpn.com:51820";
            allowedIPs = ["0.0.0.0/0"];
          }
        ];
      };
    };
  };
  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };
  };
}
