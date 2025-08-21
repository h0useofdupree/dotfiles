{config, ...}: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };

      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "git";
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };

      "gitlab-stroeer" = {
        hostname = "gitlab.com";
        user = "git";
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_stroeer_gitlab";
        identitiesOnly = true;
      };
    };
  };
}
