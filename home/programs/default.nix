{pkgs, ...}: {
  imports = [
    ./anyrun
    ./browsers/firefox.nix
    ./browsers/qutebrowser
    ./browsers/zen.nix
    ./media
    ./gtk.nix
    ./office
    ./qt.nix
    ./scripts
  ];

  home.packages = with pkgs; [
    ausweisapp
    bitwarden-desktop

    signal-desktop
    tdesktop

    gnome-calculator
    gnome-control-center
    grc

    # TODO: Add seperate programs folder for latex and stuff
    # WARNING: Temporary
    jabref

    overskride
    resources
    wineWowPackages.wayland

    viddy
  ];
}
