{pkgs, ...}: {
  imports = [./themes.nix];

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
        audio_cache = true;
        normalization = false;
        autoplay = true;
        volume = 100;
        bitrate = 320;
      };
      enable_notify = false;
      play_icon = "▌▌";
      pause_icon = "▶";
      client_id_command = {
        command = "${pkgs.coreutils}/bin/cat";
        args = ["/run/agenix/spotify-client-id"];
      };
    };
  };
}
