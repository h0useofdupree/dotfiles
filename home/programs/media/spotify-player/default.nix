{pkgs, ...}: {
  imports = [./themes.nix ./spotify-folders.nix];

  programs.spotify-player = {
    enable = true;
    settings = {
      theme = "default";
      copy_command = {
        command = "wl-copy";
        args = [];
      };
      device = {
        audio_cache = true;
        normalization = false;
        autoplay = true;
        volume = 100;
        bitrate = 320;
      };
      enable_notify = false;
      enable_audio_visualization = true;
      playback_window_position = "Top";
      playback_metadata_fields = ["repeat" "shuffle" "device" "volume"];
      play_icon = "▌▌";
      pause_icon = "▶";
      border_type = "Rounded";
      genre_num = 5;
      client_id_command = {
        command = "${pkgs.coreutils}/bin/cat";
        args = ["/run/agenix/spotify-client-id"];
      };
    };
  };
}
