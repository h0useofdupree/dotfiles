{
  config,
  pkgs,
  ...
}: {
  services.plex = {
    enable = false;
    openFirewall = true;
    # Use the default Plex package; override here if you prefer Plex Pass
    package = pkgs.plex;
  };

  # Allow hardware-accelerated transcoding by granting device access
  users.users.plex.extraGroups = ["video" "render"];
}
