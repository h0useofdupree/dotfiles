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
    dust
    duf
    fd
    file
    fortune
    gnumake
    go
    httpie
    jaq
    lazygit
    ncdu
    nitch
    ripgrep
    ripdrag
    librespeed-cli
    tldr
    wget
  ];

  programs = {
    eza.enable = true;
    ssh.enable = true;
  };
}
