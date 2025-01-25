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

    functions = {
      # eza (ls) settings wrapper
      eza = "command eza --group-directories-first --total-size $argv";
      # bat (cat) wrapper
      cat = "bat $argv";
      # nv (neovide) wrapper
      nv = "neovide --no-fork $argv";
      # gitignore templates
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
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
