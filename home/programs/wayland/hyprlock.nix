{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;

    settings = {
      general = {
        ignore_empty_input = true;
        immediate_render = true;
        hide_cursor = true;
        fail_timeout = 1000;
      };

      animation = [
        "inputFieldDots, 1, 3, linear"
        "fadeIn, 0"
      ];

      background = [
        {
          monitor = "";
          path = config.dynamicWallpaper.currentLink;
          blur_size = 1;
          blur_passes = 4;
        }
      ];

      image = [
        {
          monitor = "";
          path = config.home.homeDirectory + "/.face.jpg";
          size = 60;
          rounding = -1;
          border_size = 2;
          border_color = "rgba(221, 221, 221, 1.0)";
          position = "0, -50";
          halign = "center";
          valign = "top";
          zindex = 1;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 50";
          outline_thickness = 2;

          outer_color = "rgba(59, 59, 59, 0.333)";
          inner_color = "rgba(51, 51, 51, 0.067)";
          font_color = "rgba(255, 255, 255, 1.0)";

          dots_size = 0.1;
          dots_spacing = 0.3;

          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] date +%H";
          font_size = 120;
          font_family = "Inter:style=Bold";
          color = "rgba(255, 255, 255, 1.0)";
          position = "0, 400";
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_boost = 0.5;
        }

        {
          monitor = "";
          text = "cmd[update:1000] date +%M";
          font_size = 80;
          font_family = "Inter:style=Bold";
          color = "rgba(255, 255, 255, 1.0)";
          position = "0, 200";
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_boost = 0.5;
        }

        {
          monitor = "";
          text = "hi $USER";
          font_size = 20;
          font_family = "Inter";
          color = "rgba(255, 255, 255, 1.0)";
          position = "0, -300";
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_boost = 0.5;
        }
        {
          monitor = "";
          text = "lock";
          font_size = 21;
          font_family = "Material Symbols Rounded";
          color = "rgba(255, 255, 255, 1.0)";
          position = "0, 100";
          halign = "center";
          valign = "bottom";
          shadow_passes = 1;
          shadow_boost = 0.5;
        }
        {
          monitor = "";
          text = "locked";
          font_size = 30;
          font_family = "Inter:style=Bold";
          color = "rgba(255, 255, 255, 1.0)";
          position = "0, 45";
          halign = "center";
          valign = "bottom";
          shadow_passes = 1;
          shadow_boost = 0.5;
        }
      ];
    };
  };
}
