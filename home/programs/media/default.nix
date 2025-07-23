{pkgs, ...}: {
  imports = [
    ./mpv.nix
    ./spotify-player
  ];

  home.packages = with pkgs; [
    # Audio control
    pulsemixer
    pwvucontrol
    pulseaudio

    # Audio
    amberol
    # spotify

    # File Manager
    nautilus

    # Image
    loupe

    # Video
    celluloid

    # Torrents
    transmission_4-gtk
  ];
}
