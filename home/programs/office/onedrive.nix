{
  config,
  pkgs,
  ...
}: {
  programs.onedrive = {
    enable = true;
    settings = ''
      sync_dir = "${config.home.homeDirectory}/PVO/OneDrive"
      skip_dir = ".*"
      skip_file = "~*|.~*|*.tmp"
      monitor_interval = "300"

      no_remote_delete = "true"
      skip_symlinks = "true"

      check_nosync = "false"
      check_nomount = "false"
    '';
  };
}
