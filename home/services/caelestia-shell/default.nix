{
  inputs,
  pkgs,
  lib,
  ...
}: let
  shellPkg = inputs.caelestia-shell.packages.${pkgs.system}.default;
  logging = lib.concatStringsSep ";" [
    "quickshell.dbus.properties.warning=false"
    "quickshell.dbus.dbusmenu.warning=false"
    "quickshell.service.notifications.warning=false"
    "quickshell.service.sni.host.warning=false"
    "qt.qpa.wayland.textinput.warning=false"
  ];
in {
  home.packages = [shellPkg];

  home.file.".config/caelestia/shell.json".source = ./shell.json;

  systemd.user.services.caelestia-shell = {
    Unit = {
      Description = "Caelestia desktop shell";
      After = ["graphical-session.target"];
    };
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      ExecStart = lib.getExe shellPkg;
      Environment = "QT_LOGGING_RULES=${logging}";
      Restart = "on-failure";
    };
  };
}
