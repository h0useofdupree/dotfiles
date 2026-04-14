{
  inputs,
  lib,
  config,
  isLaptop,
  ...
}: {
  imports = [inputs.caelestia-shell.homeManagerModules.default];

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
      environment = let
        logging = lib.concatStringsSep ";" [
          "quickshell.dbus.properties.warning=false"
          "quickshell.dbus.dbusmenu.warning=false"
          "quickshell.service.notifications.warning=false"
          "quickshell.service.sni.host.warning=false"
          "qt.qpa.wayland.textinput.warning=false"
        ];
      in [
        "QT_LOGGING_RULES=${logging}"
      ];
    };
    settings = import ./config {
      inherit config isLaptop lib;
    };
    cli.enable = true;
  };
}
