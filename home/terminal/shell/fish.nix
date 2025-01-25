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
      c = "z";
    };

    functions = {
      # eza (ls) settings wrapper
      eza = {
        body = "command eza --group-directories-first --total-size $argv";
        wraps = "eza";
        description = "eza with options (wrapper)";
      };

      # bat (cat) wrapper
      cat = {
        body = "bat $argv";
        wraps = "bat";
        description = "bat (wrapper)";
      };

      # nv (neovide) wrapper
      nv = {
        body = "neovide --no-fork $argv";
        wraps = "neovide";
      };

      # y (yazi) helper
      y = {
        body = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
        description = "yazi helper (cd cwd)";
      };

      # gitignore templates
      gitignore = {
        body = "curl -sL https://www.gitignore.io/api/$argv";
        description = "fetches a gitignore template for a given language";
      };
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
