{
  programs.nh = {
    enable = true;

    clean = {
      enable = true;
      extraArgs = "--keep-since 14d";
    };
  };
}
