{
  config,
  lib,
  pkgs,
  ...
}: {
  services.greetd = let
    session = {
      command = "${lib.getExe' pkgs.coreutils "env"} UWSM_SILENT_START=1 ${lib.getExe config.programs.uwsm.package} start hyprland.desktop";
      user = "h0useofdupree";
    };
  in {
    enable = true;
    restart = true;
    settings = {
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };

  # Unlock GPG keyring on login
  # NOTE: Does not work with autologin
  security.pam.services.greetd.enableGnomeKeyring = true;
}
