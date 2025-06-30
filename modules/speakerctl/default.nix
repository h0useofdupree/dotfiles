{
  config,
  pkgs,
  lib,
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
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.speakerctl];

    home.file.".config/speakerctl/devices.json".text = builtins.toJSON cfg.devices;
  };
}
