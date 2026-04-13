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
  # colorSyncPkg = inputs.self.packages.${system}.caelestia-colors;
  logging = lib.concatStringsSep ";" [
    "quickshell.dbus.properties.warning=false"
    "quickshell.dbus.dbusmenu.warning=false"
    "quickshell.service.notifications.warning=false"
    "quickshell.service.sni.host.warning=false"
    "qt.qpa.wayland.textinput.warning=false"
  ];
  mkThemeCommand = mode: [
    "sh"
    "-c"
    "caelestia scheme set -m ${mode} && ${lib.getExe pkgs.dconf} write /org/gnome/desktop/interface/gtk-theme \"'adw-gtk3-${mode}'\""
  ];
in {
  home = {
    packages = [
      shellPkg
      quickshellPkg
      cliPkg
      # colorSyncPkg
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
