{
  config,
  pkgs,
  ...
}: {
  programs.onedrive = {
    enable = true;
    settings = {
      sync_dir = "${config.home.homeDirectory}/Projects/PVO/OneDrive";
      skip_dir = ".*";
      skip_file = "~*|.~*|*.tmp";
      monitor_interval = "300";

      no_remote_delete = "true";
      upload_only = "true";
      skip_symlinks = "true";

      check_nosync = "false";
      check_nomount = "false";
    };
  };
}
