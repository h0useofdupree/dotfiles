{
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.git;
  # TODO: key
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1JYHp/ZXHErtQVer2eE393NoJgOB6LvVJ+x/IxayS9 joel.riekemann@gmail.com";
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

  xdg.configFile."git/allowed_signers".text = ''
    ${cfg.userEmail} namespaces="git" ${key}
  '';
}
