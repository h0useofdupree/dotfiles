{
    config,
    pkgs,
    ...
}: let
    cfg = config.programs.git;
    # TODO: key
in {
    home.packages = [pkgs.gh];

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

        ignores = ["*~" "*.swp" "*result*" ".direnv" "node_modules"];

        # TODO: signing
        # signing = {
        #     key = "${config.home.homeDirectory}/.ssh/id_ed25519";
        #     signByDefault = true;
        # };

        extraConfig = {
            # TODO: gpg
            # gpg = {
            #     format = "ssh";
            #     ssh.allowedSignersFile = config.home.homeDirectory + "/" + config.xdg.configFile."git/allowed_signers".target;
            # };
            pull.rebase = true;
            init.defaultBranch = "main";
        };

        userEmail = "joel.riekemann@gmail.com";
        userName = "h0useofdupree"; 
    };

    # TODO: allow signing
    # xdg.configFile."git/allowed_signers".text = ''
    #     ${cfg.userEmail} namespaces="git" ${key}
    # '';
}
