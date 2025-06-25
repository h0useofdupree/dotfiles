{pkgs, ...}: {
  imports = [
    ./keymaps.nix
  ];
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = false;
          level = 16;
          logFile = "/tmp/nvim.log";
        };

        clipboard = {
          enable = true;
          providers = {
            wl-copy.enable = true;
          };
          registers = "unnamedplus";
        };

        diagnostics = {
          enable = true;
          config = {
            virtual_lines = {
              only_current_line = true;
            };
            virtual_text = false;
            underline = true;
            signs = {
              text = {
                "vim.diagnostic.severity.ERROR" = "";
                "vim.diagnostic.severity.WARN" = "";
                "vim.diagnostic.severity.INFO" = "";
                "vim.diagnostic.severity.HINT" = "󰌶";
              };
            };
            update_in_insert = false;
          };
        };

        extraPlugins = {
          betterEscape = {
            package = pkgs.vimPlugins.better-escape-nvim;
            setup = ''
              require("better_escape").setup {
                default_mappings = false,
                mappings = {
                  i = {
                    j = {
                      j = "<Esc>",
                    },
                  },
                },
              }
            '';
          };
          spider = {
            package = pkgs.vimPlugins.nvim-spider;
            setup = ''
              require("spider").setup {
                skipInsignificantPunctuation = true,
                consistentOperatorPending = false,
                subwordMovement = true,
                customPatterns = {},
              }
            '';
          };
        };

        options = {
          updatetime = 100;
          timeoutlen = 500;

          # Line numbers
          relativenumber = true;
          number = true;
          hidden = true; # Keep closed buffer open in the background
          mouse = "a";
          mousemodel = "extend";
          splitbelow = true;
          splitright = true;

          swapfile = false;
          modeline = true;
          modelines = 100;
          undofile = true;
          incsearch = true;
          inccommand = "split";
          ignorecase = true;
          smartcase = true;
          scrolloff = 8;
          cursorline = false;
          cursorcolumn = false;
          signcolumn = "yes";
          laststatus = 3;
          fileencoding = "utf-8";
          termguicolors = true;
          wrap = true;

          # Tab options
          tabstop = 2; # Number of spaces a <Tab> represents
          shiftwidth = 2; # Number of spaces for each (auto)indent
          expandtab = true; # Expand <Tab> to spaces in Insert mode
          autoindent = true;

          textwidth = 0;

          # Folding
          foldlevel = 300; # Folds deeper than this level are closed
        };

        spellcheck = {
          enable = false;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = true;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = true;
          otter-nvim.enable = true;
          nvim-docs-view = {
            enable = false;
            mappings = {
              viewToggle = "";
              viewUpdate = "";
            };
          };
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          markdown.enable = true;
          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          html.enable = true;
          sql.enable = true;
          java.enable = true;
          kotlin.enable = true;
          ts.enable = true;
          go.enable = true;
          lua.enable = true;
          zig.enable = true;
          python.enable = true;
          typst.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };

          assembly.enable = false;
          astro.enable = false;
          nu.enable = false;
          csharp.enable = false;
          julia.enable = false;
          vala.enable = false;
          scala.enable = false;
          r.enable = false;
          gleam.enable = false;
          dart.enable = false;
          ocaml.enable = false;
          elixir.enable = false;
          haskell.enable = false;
          ruby.enable = false;

          tailwind.enable = false;
          svelte.enable = false;
          nim.enable = false;
        };

        visuals = {
          nvim-scrollbar.enable = false;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;
          indent-blankline.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            # theme = "auto";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "macchiato";
          transparent = false;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter = {
          fold = true;
          context.enable = true;
        };

        binds = {
          whichKey = {
            enable = true;
            register = {
              "<leader>/" = "Toggle Line Comment";
            };
          };
          cheatsheet.enable = true;
        };

        # TODO: Support C-j and C-k binds for up/down
        telescope.enable = true;
        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        minimap = {
          codewindow.enable = true;
        };

        dashboard = {
          alpha.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = true;
        };

        utility = {
          icon-picker.enable = true;
          surround.enable = true;
          diffview-nvim.enable = true;
          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = false;
          };
        };

        notes = {
          mind-nvim.enable = true;
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts = {
              custom_colorcolumn = {
                nix = "110";
                ruby = "120";
                java = "130";
                go = ["90" "130"];
              };
            };
          };
          fastaction.enable = true;
        };

        assistant = {
          copilot = {
            enable = true;
            cmp.enable = true;

            mappings = {
              panel = {
                open = "<C-CR>";
              };
            };
          };
        };

        comments = {
          comment-nvim = {
            enable = true;
            mappings = {
              # TODO: Map <leader>/ to toggle line-comment in VISUAL mode
              toggleCurrentLine = "<leader>/";
            };
          };
        };
      };
    };
  };
}
