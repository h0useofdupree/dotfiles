{pkgs, ...}: {
  home.packages = [pkgs.spotify-folders];
  systemd = {
    user = {
      services.spotify-folders-sync = {
        Unit = {
          Description = "Sync Spotify folder structure for spotify-player";
          After = ["network.target"];
        };
        Service = {
          Type = "oneshot";
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/.cache/spotify-player";
          ExecStart = "${pkgs.bash}/bin/sh -c '${pkgs.spotify-folders}/bin/spotify-folders > %h/.cache/spotify-player/PlaylistFolders_cache.json'";
        };
      };
      timers.spotify-folders-sync = {
        Unit.Description = "Daily sync of Spotify folders";
        Timer = {
          OnCalendar = "daily";
          Persistent = true;
        };
        Install.WantedBy = ["timers.target"];
      };
    };
  };
}
