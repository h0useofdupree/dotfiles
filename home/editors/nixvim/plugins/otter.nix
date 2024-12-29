{...}: {
  programs.nixvim.plugins = {
    otter = {
      enable = true;
      autoActivate = true;
      lazyLoad.enable = true;
    };
  };
}
