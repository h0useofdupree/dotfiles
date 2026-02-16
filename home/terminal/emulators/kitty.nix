{
  programs.kitty = {
    enable = true;

    font = {
      size = 13;
      name = "MesloLGLDZ Nerd Font Mono";
    };

    settings = {
      scrollback_lines = 10000;
      placement_strategy = "center";

      enabled_layouts = "fat:bias=80;full_size=1;mirrored=false";

      allow_remote_control = true;
      enable_audio_bell = false;
      visual_bell_duration = "0.1";

      copy_on_select = "clipboard";

      background_opacity = "0.60";
      window_padding_width = "20";

      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = "cursor";

      confirm_os_window_close = "0";

      cursor_trail = "3";
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = "1";
    };

    # themeFile = "Catppuccin-Macchiato";
  };

  # xdg.configFile."kitty/dark-theme.auto.conf".source = ./kitty-themes/dark-theme.auto.conf;
  # xdg.configFile."kitty/light-theme.auto.conf".source = ./kitty-themes/light-theme.auto.conf;
}
