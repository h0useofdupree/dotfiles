{pkgs, ...}: {
  home.packages = with pkgs; [
    zip
    unzip
    unrar

    libnotify
    #sshfs

    comma
    du-dust
    duf
    fd
    file
    jaq
    ripgrep
    ripdrag
  ];

  programs = {
    eza.enable = true;
    ssh.enable = true;
  };
}
