{
  config,
  lib,
  ...
}: {
  services.greetd = let
    session = {
      command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
      user = "h0useofdupree";
    };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      binPath = "/run/current-system/sw/bin/Hyprland";
      prettyName = "Hyprland";
      comment = "Hyprland UWSM";
    };
  };

  # Unlock GPG keyring on login
  # NOTE: Does not work with autologin
  security.pam.services.greetd.enableGnomeKeyring = true;
}
