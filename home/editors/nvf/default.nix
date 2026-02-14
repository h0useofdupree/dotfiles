{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./keymaps
    ./plugins
    ./theme.nix
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
        globals = {
          neovide_padding_top = 0;
          neovide_padding_bottom = 0;
          neovide_padding_right = 0;
          neovide_padding_left = 0;
          neovide_opacity = 0.85;
          neovide_normal_opacity = 0.8;
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
            # virtual_lines = {
            #   only_current_line = true;
            # };
            virtual_lines = false;
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
                  t = {
                    ["<leader>"] = {
                      q = "<C-\\><C-n>",
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

          # Plugin to provide JSON schemas
          schemastore = {
            package = pkgs.vimPlugins.SchemaStore-nvim;
          };

          # Plugin that registers json-ls manually
          jsonLsp = {
            package = pkgs.vimPlugins.nvim-lspconfig;
            setup = ''
              local lspconfig = require("lspconfig")
              local schemastore = require("schemastore")

              lspconfig.jsonls.setup {
                cmd = { "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server", "--stdio" },
                capabilities = capabilities,
                on_attach = default_on_attach,
                settings = {
                  json = {
                    schemas = schemastore.json.schemas(),
                    validate = { enable = true },
                  },
                },
                init_options = {
                  provideFormatter = true,
                },
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
          linespace = 8;

          # Tab options
          tabstop = 2; # Number of spaces a <Tab> represents
          shiftwidth = 2; # Number of spaces for each (auto)indent
          expandtab = true; # Expand <Tab> to spaces in Insert mode
          autoindent = true;

          textwidth = 0;
          sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal";

          # Persist folds + curso position across sessions with :mkview/:loadview
          viewoptions = "folds,cursor";

          # Folding
          foldcolumn = "1";
          foldlevel = 99; # Folds deeper than this level are closed
          foldlevelstart = 99;
          foldenable = true;
          foldmethod = "manual";
          # foldexpr = "nvim_treesitter#foldexpr()";

          # Window title: show shortened file path (not CWD)
          title = true;
          # Use expand('%:p:~') for full path with '~', then pathshorten() to compact directories
          titlestring = "%{pathshorten(expand('%:p:~'))}";
        };

        augroups = [
          {
            name = "PersistFolds";
            clear = true;
          }
        ];

        autocmds = [
          {
            event = ["BufWinLeave"];
            pattern = ["*"];
            group = "PersistFolds";
            desc = "Save folds and cursor position for real file buffers";
            callback =
              lib.generators.mkLuaInline
              /*
              lua
              */
              ''
                function(args)
                  local ignored_view_filetypes = {
                    "gitcommit",
                    "gitrebase",
                    "svn",
                    "hgcommit",
                  }

                  local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
                  local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
                  local name = vim.api.nvim_buf_get_name(args.buf)

                  if buftype ~= "" or filetype == "" then
                    return
                  end

                  if name == "" or name:match("^/tmp/") then
                    return
                  end

                  if vim.tbl_contains(ignored_view_filetypes, filetype) then
                    return
                  end

                  vim.cmd("silent! mkview")
                end
              '';
          }
          {
            event = ["BufWinEnter"];
            pattern = ["*"];
            group = "PersistFolds";
            desc = "Restore folds and cursor position";
            command = "silent! loadview";
          }
        ];

        spellcheck = {
          enable = false;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = true;
          lightbulb.enable = true;
          lspsaga.enable = true;
          trouble.enable = true;
          lspSignature.enable = false;
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

          assembly.enable = true;
          nix = {
            enable = true;
            lsp = {
              enable = true;
              servers = ["nil"];
            };
            treesitter = {
              enable = true;
            };
          };
          markdown = {
            enable = true;
            extensions = {
              render-markdown-nvim = {
                enable = true;
              };
            };
          };
          bash = {
            enable = true;
          };
          clang.enable = true;
          csharp.enable = true;
          css.enable = true;
          # BUG: Broken
          html.enable = false;
          sql.enable = true;
          java.enable = true;
          kotlin.enable = true;
          ts.enable = true;
          go.enable = true;
          lua.enable = true;
          # BUG: Broken
          zig.enable = false;
          python = {
            enable = true;
            format = {
              enable = true;
              type = ["black"]; #NOTE: ["black", "black-and-isort", "isort", "ruff"]
            };
            lsp = {
              enable = true;
              servers = ["basedpyright"];
            };
            treesitter.enable = true;
          };
          typst.enable = true;
          rust = {
            enable = true;
            extensions.crates-nvim.enable = true;
          };
          svelte.enable = true;
          yaml.enable = true;

          astro.enable = false;
          nu.enable = false;
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

        mini = {
          statusline = {
            enable = false;
          };
        };

        # FIX: Theme is ugly and unreadable
        # luaConfigPost = ''
        #   ${builtins.readFile ./lua/themes/m3scheme.lua}
        # '';

        autopairs.nvim-autopairs.enable = true;
        autocomplete = {
          nvim-cmp.enable = false;
          blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
            setupOpts = {
              signature = {
                enabled = true;
                window = {
                  border = "rounded";
                };
                trigger = {
                  enabled = true;
                  show_on_trigger_character = true;
                  show_on_insert_on_trigger_character = true;
                };
              };
              completion = {
                list.selection = {
                  preselect = true;
                  auto_insert = true;
                };
                documentation = {
                  auto_show = true;
                  auto_show_delay_ms = 200;
                };
                menu = {
                  auto_show = true;
                  draw = {
                    padding = 3;
                    gap = 3;
                  };
                };
                ghost_text.enabled = true;
              };
              keymap = {
                preset = "default";
              };
              cmdline = {
                keymap = {
                  preset = "default";
                };
                completion = {
                  menu = {
                    auto_show = true;
                  };
                };
              };
            };
          };
        };
        snippets = {
          luasnip = {
            enable = true;
            setupOpts = {
              enable_autosnippets = true;
            };
          };
        };

        tabline = {
          nvimBufferline = {
            enable = true;
            setupOpts = {
              options = {
                tab_size = 18;
                indicator.style = "icon";
              };
            };
          };
        };

        treesitter = {
          fold = true;
          context.enable = false;
        };

        binds = {
          whichKey = {
            enable = true;
            register = {
              "<leader>/" = "Toggle Line/Block Comment";
            };
          };
          cheatsheet.enable = true;
        };

        telescope.enable = false;
        fzf-lua = {
          enable = true;
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        minimap = {
          # BUG: Broken due to some ts_utils issue
          codewindow.enable = false;
          minimap-vim.enable = true;
        };

        dashboard = {
          alpha = {
            enable = true;
          };
          startify = {
            enable = false;
            # bookmarks = {
            #   f = "~/.dotfiles/flake.nix";
            #   c = "~/.dotfiles/home/editors/nvf/default.nix";
            # };
          };
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
          direnv.enable = true;
          motion = {
            hop.enable = true;
            leap.enable = false;
            precognition.enable = false;
          };
        };

        notes = {
          mind-nvim.enable = false;
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders = {
            enable = true;
            plugins = {
              fastaction.enable = true;
              lsp-signature.enable = true;
              nvim-cmp.enable = false;
              which-key.enable = true;
            };
          };
          noice.enable = true;
          colorful-menu-nvim.enable = true;
          colorizer = {
            enable = true;
            setupOpts = {
              filetypes = {
                "*" = {};
              };
            };
          };
          illuminate.enable = true;
          breadcrumbs = {
            enable = false;
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
          modes-nvim = {
            enable = true;
            setupOpts = {
              line_opacity.visual = 0.2;
            };
          };
          nvim-ufo = {
            enable = true;
            setupOpts = {
              # Use LSP, then Treesitter, then indent
              provider_selector =
                lib.generators.mkLuaInline
                #lua
                ''
                  function(_, filetype, buftype)
                    local function handleFallbackException(bufnr, err, providerName)
                      if type(err) == "string" and err:match "UfoFallbackException" then
                        return require("ufo").getFolds(bufnr, providerName)
                      else
                        return require("promise").reject(err)
                      end
                    end

                    return (filetype == "" or buftype == "nofile") and "indent"
                        or function(bufnr)
                          return require("ufo")
                              .getFolds(bufnr, "lsp")
                              :catch(
                                function(err)
                                  return handleFallbackException(bufnr, err, "treesitter")
                                end
                              )
                              :catch(
                                function(err)
                                  return handleFallbackException(bufnr, err, "indent")
                                end
                              )
                        end
                  end,
                '';
              close_fold_kinds_for_ft = {default = ["comment" "imports"];};
              preview = {
                win_config = {
                  border = "rounded";
                  winblend = 12;
                  winhighlight = "Normal:Normal";
                  maxheight = 20;
                };
                mappings = {
                  scrollU = "<C-u>";
                  scrollD = "<C-d>";
                  jumpTop = "[";
                  jumpBot = "]";
                  close = "q";
                  switch = "<Tab>";
                  trace = "<CR>";
                };
              };
            };
          };
        };

        assistant = {
          chatgpt = {
            enable = false;
          };
          copilot = {
            enable = false;
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
              toggleCurrentLine = "<leader>/";
              toggleSelectedLine = "<leader>/";
            };
          };
        };
      };
    };
  };
}
