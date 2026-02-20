{
  pkgs,
  lib,
  config,
  inputs,
  isLaptop ? false,
  ...
}: let
  lock = "${pkgs.systemd}/bin/loginctl lock-session";

  brillo = lib.getExe pkgs.brillo;

  # 20min
  timeout = 1200;
in {
  services.hypridle = {
    enable = false;

    package = inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.hypridle;

    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = "pgrep hyprlock || ${lib.getExe config.programs.hyprlock.package}";
      };

      listener =
        lib.optionals isLaptop [
          {
            timeout = timeout - 10;
            # save the current brightness and dim the screen over a period of 500ms
            on-timeout = "${brillo} -O; ${brillo} -u 500000 -S 10";
            # brighten the screen over a period of 250ms to the saved value
            on-resume = "${brillo} -I -u 250000";
          }
        ]
        ++ [
          {
            inherit timeout;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = timeout + 10;
            on-timeout = lock;
          }
        ];
    };
  };
  # systemd.user.services.hypridle.Unit.After = lib.mkForce "graphical-session.target";
}
