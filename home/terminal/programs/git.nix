{
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.git;
  # TODO: key
  pubKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1JYHp/ZXHErtQVer2eE393NoJgOB6LvVJ+x/IxayS9 joel.riekemann@gmail.com";
in {
  home.packages = [pkgs.gh];

  # Enable scrolling in `git diff` and `git log`
  home.sessionVariables.DELTA_PAGER = "less -R";

  programs.git = {
    enable = true;

    delta = {
      enable = true;
      options.dark = true;
    };

    extraConfig = {
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
    };

    aliases = let
      log = "log --show-notes='*' --abbrev-commit --pretty=format:'%Cred%h %Cgreen(%aD)%Creset -%C(bold red)%d%Creset %s %C(bold blue)<%an>% %Creset' --graph";
    in {
      a = "add --patch";
      ad = "add";

      b = "branch";
      ba = "branch -a";

      c = "commit";
      ca = "commit --amend";
      cm = "commit -m";

      co = "checkout";
      cb = "checkout -b";

      cl = "clone";

      d = "diff";
      ds = "diff --staged";

      l = "log";
      lp = "${log} --patch";
      la = "${log} --all";
    };

    ignores = ["*~" "*.swp" "*result*" ".direnv" "node_modules"];

    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519";
      signByDefault = true;
    };

    extraConfig = {
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = config.home.homeDirectory + "/" + config.xdg.configFile."git/allowed_signers".target;
      };
      pull.rebase = true;
      init.defaultBranch = "main";
    };

    userEmail = "joel.riekemann@gmail.com";
    userName = "h0useofdupree";
  };

  programs.git-cliff = {
    enable = true;
    settings = {
      header = "Changelog";
      trim = true;

      changelog = {
        path = "CHANGELOG.md";
        tag_pattern = "^[0-9]+\\.[0-9]+\\.[0-9]+(-[a-z]+)?$"; # supports -beta, -stable
        include_unreleased = true;
        sort_commits = "newest";
        filter_commits = true;
      };

      commit_parsers = [
        # New conventional commits
        {pattern = "^(?P<type>feat|fix|docs|style|refactor|perf|test|chore)(\\([^)]*\\))?: ";}

        # Old-style path prefixes (past commits)
        {pattern = "^(?P<type>h/p/w/hyprpanel):";}
        {pattern = "^(?P<type>s/p/hyprland):";}
        {pattern = "^(?P<type>hosts/linx):";}
        {pattern = "^(?P<type>hosts/nixus):";}
        {pattern = "^(?P<type>secrets):";}
        {pattern = "^(?P<type>flake\\.lock):";}
        {pattern = "^(?P<type>README):";}
      ];

      commit_types = [
        {
          type = "feat";
          section = "✨ Features";
        }
        {
          type = "fix";
          section = "🐛 Fixes";
        }
        {
          type = "docs";
          section = "📝 Docs";
        }
        {
          type = "style";
          section = "🎨 Styling";
        }
        {
          type = "refactor";
          section = "🛠 Refactors";
        }
        {
          type = "perf";
          section = "⚡ Performance";
        }
        {
          type = "test";
          section = "✅ Tests";
        }
        {
          type = "chore";
          section = "🧹 Chores";
        }

        # Custom commit categories based on your prefixes
        {
          type = "h/p/w/hyprpanel";
          section = "🧱 Hyprpanel Config";
        }
        {
          type = "s/p/hyprland";
          section = "🎮 Hyprland System";
        }
        {
          type = "hosts/linx";
          section = "💻 Linx Host";
        }
        {
          type = "hosts/nixus";
          section = "🖥 Nixus Host";
        }
        {
          type = "secrets";
          section = "🔐 Secrets";
        }
        {
          type = "flake.lock";
          section = "📦 Flake Lock Updates";
        }
        {
          type = "README";
          section = "📚 Documentation";
        }
      ];
    };
  };

  xdg.configFile."git/allowed_signers".text = ''
    ${cfg.userEmail} namespaces="git" ${pubKey}
  '';
}
