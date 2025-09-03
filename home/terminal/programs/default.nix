{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./cli.nix
    ./codex.nix
    ./fzf.nix
    ./git.nix
    ./ssh.nix
    ./nix.nix
    ./zoxide.nix
    ./xdg.nix
    ./yazi
  ];

  home.packages = with pkgs; [
    cava
    rclone
  ];
}
