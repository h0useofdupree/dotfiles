{
  programs.nvf.settings.vim = {
    filetree = {
      neo-tree = {
        enable = true;
        setupOpts = {
          enable_cursor_hijack = true;
          close_if_last_window = true;
          auto_clean_after_session_restore = true;
          source_selector = {
            statusline = false;
            winbar = true;
            sources = [
              {
                source = "filesystem";
                display_name = "File";
              }
              {
                source = "buffers";
                display_name = "Bufs";
              }
              {
                source = "git_status";
                display_name = "Git";
              }
              {
                source = "document_symbols";
                display_name = "DS";
              }
            ];
          };

          sources = [
            "filesystem"
            "buffers"
            "git_status"
            "document_symbols"
          ];

          default_component_configs = {
            indent = {
              padding = 0;
              expander_collapsed = ""; # Use nerd font or replace if needed
              expander_expanded = "";
            };
            icon = {
              folder_closed = "";
              folder_open = "";
              folder_empty = "";
              folder_empty_open = "";
              default = "";
            };
            modified = {
              symbol = "[+]";
            };
            git_status = {
              symbols = {
                added = "✚";
                deleted = "✖";
                modified = "";
                renamed = "➜";
                untracked = "★";
                ignored = "◌";
                unstaged = "✗";
                staged = "✓";
                conflict = "";
              };
            };
          };

          filesystem = {
            follow_current_file = {enabled = true;};
            filtered_items = {
              hide_gitignored = true;
            };
            hijack_netrw_behavior = "open_default";
          };

          window = {
            width = 30;
          };
        };
      };
    };
  };
}
