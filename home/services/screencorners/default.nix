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
      Description = "AGS Screencorners";
      After = ["graphical-session.target" "hyprland-session.target"];
      PartOf = ["graphical-session.target"];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };

    Service = {
      ExecStart = ''
        ${pkgs.bash}/bin/bash -c '
          until ${pkgs.hyprland}/bin/hyprctl monitors | grep -q "^Monitor .* (ID [0-9]\\+):"; do
            sleep 0.2
          done

          if ${pkgs.procps}/bin/pgrep -f "ags -c .*corners.js"; then
            exit 0
          fi

          exec ${inputs.ags.packages.${pkgs.system}.ags}/bin/ags -c ~/.config/ags/corners.js
        '
      '';
      Restart = "on-failure";
      RestartSec = 2;
      KillMode = "mixed";
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
