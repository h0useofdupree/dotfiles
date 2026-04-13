{
  inputs,
  pkgs,
  lib,
  config,
  isLaptop,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  shellPkg = inputs.caelestia-shell.packages.${system}.default;
  quickshellPkg = inputs.quickshell.packages.${system}.default.override {
    withX11 = false;
    withI3 = false;
  };
  cliPkg = inputs.caelestia-cli.packages.${system}.default.override {
    python3 = pkgs.python314;
  };
  logging = lib.concatStringsSep ";" [
    "quickshell.dbus.properties.warning=false"
    "quickshell.dbus.dbusmenu.warning=false"
    "quickshell.service.notifications.warning=false"
    "quickshell.service.sni.host.warning=false"
    "qt.qpa.wayland.textinput.warning=false"
  ];
in {
  home = {
    packages = [
      shellPkg
      quickshellPkg
      cliPkg
    ];

    # TODO: Switch to hm module or rework how we handle the flake/shell.json config
    file.".config/caelestia/shell.json".text = builtins.toJSON (import ./config {
      inherit config isLaptop lib;
    });
  };

  # Services
  systemd = {
    user = {
      services = {
        caelestia-shell = {
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
      };
    };
  };
}
