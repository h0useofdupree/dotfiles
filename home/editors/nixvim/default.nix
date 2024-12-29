{...}: {
  imports = [
    ./plugins
    ./options.nix
  ];
  programs = {
    nixvim = {
      enable = true;
      defaultEditor = true;
      enableMan = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      colorschemes.catppuccin.enable = true;

      globals = {
        neovide.transparency = 0.8;
      };

      plugins = {
        conform-nvim = {
          enable = true;
          lazyLoad.enable = true;
        };
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
          };
        };

        lualine.enable = true;
        mini = {
          enable = true;
          mockDevIcons = true;
          modules = {
            icons = {
              style = "glyph";
            };
            surround = {
              mappings = {
                add = "gsa";
                delete = "gsd";
                find = "gsf";
                find_left = "gsF";
                highlight = "gsh";
                replace = "gsr";
                update_n_lines = "gsn";
              };
            };
          };
        };
        treesitter = {
          enable = true;

          nixvimInjections = true;

          folding = true;
          settings = {
            indent.enable = true;
            highlight.enable = true;
            # ensure_installed = "all";
            auto_install = true;
          };
        };

        treesitter-refactor = {
          enable = true;
          highlightDefinitions = {
            enable = true;
            # Set to false if you have an `updatetime` of ~100.
            clearOnCursorMove = false;
          };
        };

        hmts.enable = true;
      };
    };
  };
}
