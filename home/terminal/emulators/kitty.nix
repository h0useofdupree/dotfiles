{
  programs.kitty = {
    enable = true;

    font = {
      size = 13;
      name = "Cascadia Mono NF";
    };

    settings = {
      scrollback_lines = 10000;
      placement_strategy = "center";

      allow_remote_control = "yes";
      enable_audio_bell = "no";
      visual_bell_duration = "0.1";

      copy_on_select = "clipboard";

      background_opacity = "0.8";
      window_padding_width = "30";

      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = "cursor";

      confirm_os_window_close = "0";
    };

    themeFile = "Catppuccin-Macchiato";
  };
}
