{pkgs, ...}: {
  imports = [
    ./anyrun
    ./browsers/firefox.nix
    ./browsers/qutebrowser.nix
    ./browsers/zen.nix
    ./media
    ./gtk.nix
    ./office
    ./qt.nix
  ];

  home.packages = with pkgs; [
    signal-desktop
    tdesktop

    gnome-calculator
    gnome-control-center
    grc

    overskride
    mission-center
    wineWowPackages.wayland
  ];
}
