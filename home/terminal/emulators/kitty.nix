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

      background_opacity = "0.65";
      window_padding_width = "30";

      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = "cursor";

      confirm_os_window_close = "0";

      cursor_trail = "3";
      cursor_trail_decay = "0.1 0.4";
    };

    themeFile = "Catppuccin-Macchiato";
  };

  # xdg.configFile."kitty/dark-theme.auto.conf".source = ./kitty-themes/dark-theme.auto.conf;
  # xdg.configFile."kitty/light-theme.auto.conf".source = ./kitty-themes/light-theme.auto.conf;
}
