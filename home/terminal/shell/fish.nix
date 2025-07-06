{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    generateCompletions = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      nitch

      ${lib.optionalString config.services.gpg-agent.enable ''
        if test -n "$XDG_RUNTIME_DIR"
          set -l gnupg_path (ls $XDG_RUNTIME_DIR/gnupg)
          set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gnupg/$gnupg_path/S.gpg-agent.ssh"
      ''}
    '';

    shellInitLast = ''
      bind --erase \cf
      bind --erase \ca
      bind --erase \cw
      bind --erase -k nul

      bind \ca accept-autosuggestion
      bind \cf forward-bigword
      bind -k nul forward-word
      bind \cw backward-kill-word
    '';

    shellAbbrs = {
      lg = "lazygit";
      cdd = "cd ~/.dotfiles/";
      c = "z";
      watch = "viddy";
    };

    functions = {
      spt = {
        body = ''
          kitten @ set-spacing padding=10
          spotify_player
          kitten @ set-spacing padding=default
        '';
        wraps = "spotify-player";
        description = "spotify-player (kitty padding adjusted)";
      };

      icat = {
        body = "kitten icat $argv";
        wraps = "kitten icat";
        description = "shortcut for kitten icat";
      };

      eza = {
        body = "command eza --group-directories-first $argv";
        wraps = "eza";
        description = "eza with options (wrapper)";
      };

      cat = {
        body = "bat $argv";
        wraps = "bat";
        description = "bat (wrapper)";
      };

      poweroff = {
        body = ''
          if command -v speakerctl &>/dev/null
            speakerctl --off
          end
          command poweroff $argv
        '';
        description = "poweroff with speakers off";
      };

      reboot = {
        body = ''
          if command -v speakerctl &>/dev/null
            speakerctl --off
          end
          command reboot $argv
        '';
        description = "reboot with speakers off";
      };

      nv = {
        body = "neovide --no-fork $argv";
        wraps = "neovide";
      };

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
      {
        name = "colored-man-pages";
        inherit (pkgs.fishPlugins.colored-man-pages) src;
      }
    ];
  };
}
