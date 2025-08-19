{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./fish_completions
  ];
  programs.fish = {
    enable = true;
    generateCompletions = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      command cat ~/.local/state/caelestia/sequences.txt 2> /dev/null

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

    shellAliases = lib.mkForce {};

    shellAbbrs = {
      cdd = "cd ~/.dotfiles/";
      c = "z";
      g = "git";
      lg = "lazygit";
      ls = "eza";
      nhs = "nh os switch";
      py = "python3";
      watch = "viddy";
      wlc = "wl-copy";
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

      la = {
        body = "eza -a --icons always $argv";
        wraps = "eza -a --icons always --git";
        description = "alias la eza -a --icons always";
      };

      ll = {
        body = "eza -l --icons always --git $argv";
        wraps = "eza -l --icons always --git";
        description = "alias ll eza -l --icons always --git";
      };

      lla = {
        body = "eza -la --icons always --git $argv";
        wraps = "eza -la --icons always --git";
        description = "alias lla eza -la --icons always --git";
      };

      lt = {
        body = "eza --tree $argv";
        wraps = "eza --tree";
        description = "alias lt eza --tree";
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

      meet = {
        body = ''
          hyprctl keyword monitor "DP-1, 3440x1440@144,auto,1.6"
          set action (notify-send \
            -u normal \
            -i dialog-information-symbolic \
            -A disable="Disable" \
            --wait \
            "Meeting mode on" \
            "Scale has been increased temporarily")

          if test "$action" = "disable"
            hyprctl reload
          end
        '';
        description = "aio command for meetings (incl. larger scale)";
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

      wp-groups-summary = {
        body = ''
          set -l root ${config.home.homeDirectory}/.dotfiles/lib/wallpapers
          if test (count $argv) -ge 1
              set root $argv[1]
          end

          if not test -d "$root"
              echo "wp-groups-summary: root not found: $root" >&2
              return 1
          end

          if not type -q magick
              echo "wp-groups-summary: ImageMagick 'magick' not in PATH" >&2
              return 127
          end

          for clean in (command find "$root" -mindepth 1 -maxdepth 1 -type d -print0 | string split0)
              set -l name (basename $clean)

              # skip meta dirs
              if test "$name" = archives -o "$name" = scripts
                  continue
              end

              # collect images
              set -l imgs (command find "$clean" -maxdepth 1 -type f \
                  \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \
                  -print0 | string split0)
              if test (count $imgs) -eq 0
                  continue
              end

              set -l first_img $imgs[1]
              set -l count (count $imgs)

              # fast resolution probe
              set -l res (magick identify -ping -format "%wx%h" -- "$first_img" 2>/dev/null)
              if test -z "$res"; set res "unknown"; end

              # average-ish color via 1x1
              set -l avg_hex (magick "$first_img" -resize 1x1\! -colorspace sRGB -depth 8 txt:- 2>/dev/null \
                  | string match -r '#[0-9A-Fa-f]{6}' | head -n 1)
              if test -z "$avg_hex"; set avg_hex "#000000"; end

              # brightness 0–100
              set -l bright (magick identify -format "%[fx:100*mean]" -- "$first_img" 2>/dev/null)
              if test -z "$bright"; set bright 0; end
              set -l bright_pct (printf "%.0f" $bright)

              echo "# - '$name' - $count images - $res - avg $avg_hex - ~$bright_pct% bright"
          end
        '';
        description = "Get wallpaper group name, count, res, avg color, brightness";
      };

      hyprlock-restart = {
        body = ''
          set logdir (test -n "$XDG_STATE_HOME"; and echo $XDG_STATE_HOME; or echo "$HOME/.local/state")
          set logfile "$logdir/hyprlock-restart.log"

          function _log
            echo -n (date "+%Y-%m-%d %H:%M:%S")" | " >> $logfile
            echo $argv >> $logfile
          end

          _log "===== Hyprlock Restart Triggered ====="
          _log "TTY: "(tty)
          _log "Uptime: "(uptime -p)
          _log "Kernel: "(uname -r)
          _log "User: $USER"
          _log "Shell: $SHELL"
          _log "Fish Version: "(fish --version)
          _log "Hyprctl instance list:"
          command hyprctl instances >> $logfile ^/dev/null

          echo "[hyprlock-restart] Allowing session lock restore..."
          _log "Enabling session lock restore"
          command hyprctl --instance 0 "keyword misc:allow_session_lock_restore 1"

          if pgrep -x hyprlock > /dev/null
            echo "[hyprlock-restart] Killing existing hyprlock process..."
            _log "Existing hyprlock process found. Killing it."
            command killall -9 hyprlock
            sleep 1
          else
            _log "No running hyprlock instance detected"
          end

          echo "[hyprlock-restart] Starting hyprlock..."
          _log "Starting new hyprlock instance..."
          command hyprctl --instance 0 "dispatch exec hyprlock"

          sleep 2

          echo "[hyprlock-restart] Disabling session lock restore..."
          _log "Disabling session lock restore"
          command hyprctl --instance 0 "keyword misc:allow_session_lock_restore 0"

          echo "[hyprlock-restart] Done. You can now switch back to TTY1 (Ctrl+Alt+F1)"
          _log "Restart complete — waiting for user to switch TTY"
          _log "========================================"
        '';
        description = "Restart hyprlock after a crash, with automatic logging and state info";
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
