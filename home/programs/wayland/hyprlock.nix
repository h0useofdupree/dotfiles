{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.hyprlock = {
    enable = true;

    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;

    settings = {
      general = {
        disable_loading_bar = true;
        immediate_render = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      background = [
        {
          monitor = "";
          # path = config.theme.wallpaper;
          path = "screenshot";
          blur_size = 1;
          blur_passes = 4;
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
          text = "$TIME";
          font_size = 65;
          font_family = "Inter";
          color = "rgba(255, 255, 255, 1.0)";

          position = "0, 300";
          halign = "center";
          valign = "center";

          shadow_passes = 1;
          shadow_boost = 0.5;
        }
        {
          monitor = "";
          text = "hi $USER !!!";
          font_size = 20;
          font_family = "Inter";
          color = "rgba(255, 255, 255, 1.0)";

          position = "0, 240";
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

          position = "0, 65";
          halign = "center";
          valign = "bottom";

          shadow_passes = 1;
          shadow_boost = 0.5;
        }
        {
          monitor = "";
          text = "locked";
          font_size = 14;
          font_family = "Inter";
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
