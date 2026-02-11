{pkgs, ...}: {
  imports = [
    ./browsers/firefox.nix
    ./browsers/qutebrowser
    ./browsers/zen.nix
    ./media
    ./gtk.nix
    ./office
    ./qt.nix
    ./scripts
    ./vicinae
  ];

  home.packages = with pkgs; [
    ausweisapp
    bitwarden-desktop

    signal-desktop

    gnome-calculator
    gnome-clocks
    gnome-control-center
    grc

    planify

    # TODO: Add seperate programs folder for latex and stuff
    # WARNING: Temporary
    jabref

    overskride
    resources
    wineWowPackages.wayland

    viddy
  ];
}
