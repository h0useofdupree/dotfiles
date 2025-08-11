{
  lib,
  pkgs,
  self,
  ...
}: {
  imports = [
    # ./hyprland
    ./hyprlock.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
    grim
    slurp

    self.packages.${pkgs.system}.wl-ocr
    wl-clipboard
    wlr-randr
  ];

  home.sessionVariables = {
    # Wayland compat
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    # UWSM App2Unit compat
    APP2UNIT_SLICES = "a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice";
  };
  systemd.user.targets.tray.Unit.Requires = lib.mkForce ["graphical-session.target"];
}
