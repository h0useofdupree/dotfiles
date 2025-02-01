{
  programs.spotify-player = {
    enable = true;
    settings = {
      theme = "default";
      playback_window_position = "Top";
      copy_command = {
        command = "wl-copy";
        args = [];
      };
      device = {
        audio_cache = false;
        normalization = true;
        autoplay = true;
        bitrate = 320;
        initial_volume = 100;
      };
      enable_notify = false;
      play_icon = "▌▌";
      pause_icon = "▶";
      client_id = "bd411790cddf4f6382e92bd325e8a586";
    };
  };
}
