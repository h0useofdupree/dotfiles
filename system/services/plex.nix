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

  services.jellyfin = {
    enable = false;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    jellyfin-mpv-shim
  ];
  users.users.jellyfin.extraGroups = ["video" "render"];

  # Allow hardware-accelerated transcoding by granting device access
  # users.users.plex.extraGroups = ["video" "render"];
}
