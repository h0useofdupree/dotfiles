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

    devices = mkOption {
      type = types.listOf types.attrs;
      default = [];
      description = "Device definitions written to devices.json.";
      example = [
        {
          id = "device-id";
          ip = "192.168.1.10";
          key = "abcd";
          version = 3.3;
        }
      ];
    };

    devicesFile = mkOption {
      type = with types; nullOr path;
      default = null;
      description = "Path to an existing devices.json file.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.self.packages.${pkgs.system}.speakerctl
    ];

    home.file.".config/speakerctl/devices.json" =
      if cfg.devicesFile != null
      then {source = cfg.devicesFile;}
      else {text = builtins.toJSON cfg.devices;};
  };
}
