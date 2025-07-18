{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];
  home = {
    packages = [
      inputs.ags.packages.${pkgs.system}.ags
    ];

    file = {
      ".config/ags/config.js".source = ./config.js;
      ".config/ags/corners.js".source = ./corners.js;
    };
  };

  systemd.user.services.ags-corners = {
    Unit = {
      Description = "Aylur's GTK Shell";
      PartOf = [
        # "tray.target"
        "graphical-session.target"
      ];
      After = "graphical-session.target";
    };

    Service = {
      ExecStart = "${inputs.ags.packages.${pkgs.system}.ags}/bin/ags";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
