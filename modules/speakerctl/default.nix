{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.speakerctl;
in {
  options.speakerctl = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable smart speaker control.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.self.packages.${pkgs.system}.speakerctl
    ];
  };
}
