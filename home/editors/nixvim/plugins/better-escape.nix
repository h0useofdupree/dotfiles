{...}: {
  programs.nixvim.plugins = {
    better-escape = {
      enable = true;

      settings = {
        default_mappings = false;
        mappings = {
          c = {
            j = {
              j = "<Esc>";
            };
          };
          i = {
            j = {
              j = "<Esc>";
            };
          };
          s = {
            j = {
              k = "<Esc>";
            };
          };
          t = {
            j = {
              j = "<Esc>";
            };
          };
          v = {
            j = {
              k = "<Esc>";
            };
          };
        };
      };
    };
  };
}
