_: {
  programs.nvf = {
    settings = {
      vim.keymaps = [
        # Buffer/Window close
        {
          key = "<leader>q"; # Leader + q
          mode = "n";
          silent = true;
          action = ":bd<CR>";
          desc = "Close current buffer";
        }
        {
          key = "<leader>c"; # Leader + c
          mode = "n";
          silent = true;
          action = "<C-w>c";
          desc = "which_key_ignore";
        }

        # Neotree
        {
          key = "<leader>e";
          mode = "n";
          silent = true;
          action = ":Neotree toggle<CR>";
          desc = "Toggle Neotree";
        }
        {
          key = "<leader>o";
          mode = "n";
          silent = true;
          action = ":Neotree focus<CR>";
          desc = "Focus Neotree";
        }

        # Toggle Term
        {
          key = "<leader>T";
          mode = "n";
          silent = true;
          action = ":ToggleTerm direction=float<CR>";
          desc = "Toggle floating terminal";
        }

        # Buffer navigation
        {
          key = "<S-H>"; # Shift + H
          mode = "n";
          silent = true;
          action = ":bprevious<CR>";
          desc = "Go to previous buffer";
        }
        {
          key = "<S-L>"; # Shift + L
          mode = "n";
          silent = true;
          action = ":bnext<CR>";
          desc = "Go to next buffer";
        }

        # Window navigation
        {
          key = "<C-H>"; # Ctrl + H
          mode = "n";
          silent = true;
          action = "<C-w>h";
          desc = "Go to left split";
        }
        {
          key = "<C-L>"; # Ctrl + L
          mode = "n";
          silent = true;
          action = "<C-w>l";
          desc = "Go to right split";
        }
        {
          key = "<C-J>"; # Ctrl + J
          mode = "n";
          silent = true;
          action = "<C-w>j";
          desc = "Go to split below";
        }
        {
          key = "<C-K>"; # Ctrl + K
          mode = "n";
          silent = true;
          action = "<C-w>k";
          desc = "Go to split above";
        }

        # Window dimensions
        {
          key = "<C-S-H>"; # Ctrl + Shift + H
          mode = "n";
          silent = true;
          action = ":vertical resize -2<CR>";
          desc = "Shrink split horizontally";
        }
        {
          key = "<C-S-L>"; # Ctrl + Shift + L
          mode = "n";
          silent = true;
          action = ":vertical resize +2<CR>";
          desc = "Expand split horizontally";
        }
        {
          key = "<C-S-J>"; # Ctrl + Shift + J
          mode = "n";
          silent = true;
          action = ":resize -2<CR>";
          desc = "Shrink split vertically";
        }
        {
          key = "<C-S-K>"; # Ctrl + Shift + K
          mode = "n";
          silent = true;
          action = ":resize +2<CR>";
          desc = "Expand split vertically";
        }
      ];
    };
  };
}
