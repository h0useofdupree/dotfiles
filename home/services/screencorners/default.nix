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
      Description = "screencorners (ags)";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      StartLimitIntervalSec = 10;
      StartLimitBurst = 5;
    };

    Service = {
      ExecStartPre = [
        "${pkgs.runtimeShell} -c '${pkgs.procps}/bin/pkill -u $USER -x ags || true'"
      ];
      ExecStart = "${inputs.ags.packages.${pkgs.system}.ags}/bin/ags";
      ExecStop = "${pkgs.procps}/bin/pkill -u $USER -x ags";
      Restart = "always";
      RestartSec = 2;
      KillMode = "mixed";
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
