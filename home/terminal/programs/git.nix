{
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.git;
  # TODO: key
  pubKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1JYHp/ZXHErtQVer2eE393NoJgOB6LvVJ+x/IxayS9 joel.riekemann@gmail.com";
  ghOwner = "h0useofdupree";
  ghRepo = "dotfiles";
  ghRepoUrl = "https://github.com/h0useofdupree/dotfiles";
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
      changelog = {
        path = "CHANGELOG.md";
        # tag_pattern = "^[0-9]+\\.[0-9]+\\.[0-9]+(-[a-z]+)?$";
        include_unreleased = true;
        sort_commits = "newest";
        filter_commits = false;
        header = ''
          # Changelog

          All notable changes to my configuration will be documented in this file.
        '';

        body = ''
          ---
          {% if version %}
              {% if previous.version %}
                  ## [{{ version | trim_start_matches(pat="v") }}](${ghRepoUrl}/compare/{{ previous.version }}..{{ version }}) - {{ timestamp | date(format="%Y-%m-%d") }}
              {% else %}
                  ## [{{ version | trim_start_matches(pat="v") }}] - {{ timestamp | date(format="%Y-%m-%d") }}
              {% endif %}
          {% else %}
              ## [unreleased]
          {% endif %}

          {% for group, commits in commits | group_by(attribute="group") %}
          ### {{ group | striptags | trim | upper_first }}

          {% for commit in commits | filter(attribute="scope") | sort(attribute="scope") %}
          - **({{ commit.scope }})**{% if commit.breaking %} [**breaking**]{% endif %} {{ commit.message }} - ([{{ commit.id | truncate(length=7, end="") }}](${ghRepoUrl}/commit/{{ commit.id }})) - {{ commit.author.name }}
          {% endfor %}

          {% for commit in commits %}
              {% if not commit.scope %}
              - {% if commit.breaking %} [**breaking**]{% endif %} {{ commit.message }} - ([{{ commit.id | truncate(length=7, end="") }}](${ghRepoUrl}/commit/{{ commit.id }})) - {{ commit.author.name }}
              {% endif %}
          {% endfor %}
          {% endfor %}
        '';

        footer = ''
          End of changelog
          goodbye 👋
        '';
        trim = true;
      };

      git = {
        conventional_commits = true;
        filter_unconventional = false;
        require_conventional = false;
        split_commits = false;
        sort_commits = "newest";
        filter_commits = false;

        commit_parsers = [
          {
            message = "^feat";
            group = "Features";
          }
          {
            message = "^add";
            group = "Added programs/tools";
          }
          {
            message = "^fix";
            group = "Fixes";
          }
          {
            message = "^meta";
            group = "Meta & Tooling";
          }
          {
            message = "^docs";
            group = "Documentation";
          }
          {
            message = "^style";
            group = "Styling";
          }
          {
            message = "^refactor";
            group = "Refactors";
          }
          {
            message = "^revert";
            group = "Reverts";
          }
          {
            message = "^perf";
            group = "Performance";
          }
          {
            message = "^test";
            group = "Tests";
          }
          {
            message = "^chore";
            group = "Chores";
          }
          {
            body = "^changelog: ?ignore";
            skip = true;
          }

          # For old commits that don't follow "Conventional Commits Specification"
          {
            message = "^h/p/w/hyprpanel";
            group = "Hyprpanel Config";
          }
          {
            message = "^s/p/hyprland";
            group = "Hyprland System";
          }
          {
            message = "^hosts/linx";
            group = "Linx Host";
          }
          {
            message = "^hosts/nixus";
            group = "Nixus Host";
          }
          {
            message = "^secrets";
            group = "Secrets";
          }
          {
            message = "^flake\\.lock";
            group = "Flake Lock Updates";
          }

          {
            message = ".*";
            group = "Other";
          }
        ];
      };
    };
  };

  xdg.configFile."git/allowed_signers".text = ''
    ${cfg.userEmail} namespaces="git" ${pubKey}
  '';
}
