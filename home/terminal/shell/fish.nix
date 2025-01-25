{pkgs, ...}: {
  # TODO: Run fish only interactively (see: https://nixos.wiki/wiki/Fish)
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      nitch
    '';

    shellAbbrs = {
      lg = "lazygit";
      cdd = "cd ~/.dotfiles/";
      cd = "z";
    };
    plugins = [
      {
        name = "grc";
        inherit (pkgs.fishPlugins.grc) src;
      }
      {
        name = "tide";
        inherit (pkgs.fishPlugins.tide) src;
      }
      {
        name = "puffer";
        inherit (pkgs.fishPlugins.puffer) src;
      }
      {
        name = "autopair";
        inherit (pkgs.fishPlugins.autopair) src;
      }
      {
        name = "done";
        inherit (pkgs.fishPlugins.done) src;
      }
      {
        name = "z";
        inherit (pkgs.fishPlugins.z) src;
      }
      {
        name = "fzf-fish";
        inherit (pkgs.fishPlugins.fzf-fish) src;
      }
    ];
  };
}
