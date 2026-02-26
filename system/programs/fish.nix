{
  environment.pathsToLink = ["/share/fish"];

  programs = {
    less.enable = true;

    fish = {
      enable = true;
      vendor.completions.enable = true;
      generateCompletions = true;
    };
  };
}
