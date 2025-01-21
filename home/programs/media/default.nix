{pkgs, ...}: {
  imports = [
    ./mpv.nix
    ./spotify-player.nix
  ];

  home.packages = with pkgs; [
    # Audio control
    pulsemixer
    pwvucontrol

    # Audio
    amberol
    spotify

    # Image
    loupe

    # Video
    celluloid
  ];
}
