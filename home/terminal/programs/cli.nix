{pkgs, ...}: {
  home.packages = with pkgs; [
    zip
    unzip
    unrar

    libnotify
    #sshfs

    comma
    curl
    cowsay
    du-dust
    duf
    fd
    file
    fortune
    gnumake
    go
    jaq
    lazygit
    nitch
    ripgrep
    ripdrag
    tldr
    wget
  ];

  programs = {
    eza.enable = true;
    ssh.enable = true;
  };
}
