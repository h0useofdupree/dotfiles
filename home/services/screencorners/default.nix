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

  #   systemd.user.services.screencorners = {
  #     Unit = {
  #       Description = "AGS Screencorners service";
  #       After = ["hyprland-session.target"];
  #       PartOf = ["graphical-session.target"];
  #       ConditionEnvironment = "WAYLAND_DISPLAY";
  #     };
  #
  #     Service = {
  #       Type = "simple";
  #
  #       # Wait until hyprland reports monitors
  #       ExecStartPre = pkgs.writeShellScript "wait-for-hyprland" ''
  #         export PATH=${pkgs.hyprland}/bin:${pkgs.coreutils}/bin:${pkgs.gnugrep}/bin:${pkgs.findutils}/bin:$PATH
  #
  #         echo "Waiting for HYPRLAND_INSTANCE_SIGNATURE..."
  #         while [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; do
  #           sleep 0.2
  #         done
  #
  #         echo "Waiting for at least one monitor..."
  #         while ! hyprctl monitors | grep -q "^Monitor .* (ID [0-9]\+):"; do
  #           sleep 0.2
  #         done
  #
  #         echo "Monitors detected, starting AGS..."
  #       '';
  #
  #       ExecStart = "${pkgs.hyprpanel}/bin/ags";
  #       ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
  #       Restart = "always";
  #       RestartSec = 2;
  #       KillMode = "mixed";
  #     };
  #
  #     Install = {
  #       WantedBy = ["graphical-session.target"];
  #     };
  #   };
}
