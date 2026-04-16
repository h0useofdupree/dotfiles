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
        # ---
        # NOTE: Maybe irrelevant after https://github.com/NixOS/nixpkgs/pull/506383#event-24496114538
        "QS_DROP_EXPENSIVE_FONTS=1"
      ];
    };
    settings = import ./config {
      inherit config isLaptop lib;
    };
    cli.enable = true;
  };
}
