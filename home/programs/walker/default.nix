{inputs, ...}: {
  imports = [inputs.walker.homeManagerModules.default];

  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      app_launch_prefix = "uwsm app --";
      close_when_open = false;
      timeout = 5;

      activation_mode.disabled = true;

      ui.fullscreen = true;

      search.placeholder = "make a wish...";

      list = {
        height = 200;
      };

      websearch.prefix = "?";
      switcher.prefix = "/";
    };
  };
}
