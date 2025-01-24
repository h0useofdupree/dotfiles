_: {
  programs.nvf = {
    settings = {
      vim.keymaps = [
        # Buffer/Window close
        {
          key = "<leader>q"; # Leader + q
          mode = "n";
          silent = true;
          action = ":bd<CR>"; # Close the current buffer
          desc = "Helloo";
        }
        {
          key = "<leader>c"; # Leader + c
          mode = "n";
          silent = true;
          action = "<C-w>c"; # Close the current window
        }
        # Neotree
        {
          key = "<leader>e";
          mode = "n";
          silent = true;
          action = ":Neotree toggle<CR>";
        }
        {
          key = "<leader>o";
          mode = "n";
          silent = true;
          action = ":Neotree focus<CR>";
        }
        # Toggle Term
        {
          key = "<leader>T";
          mode = "n";
          silent = true;
          action = ":ToggleTerm direction=float<CR>";
        }
        # Buffer navigation
        {
          key = "<S-H>"; # Shift + H
          mode = "n";
          silent = true;
          action = ":bprevious<CR>"; # Move to the previous buffer
        }
        {
          key = "<S-L>"; # Shift + L
          mode = "n";
          silent = true;
          action = ":bnext<CR>"; # Move to the next buffer
        }

        # Window navigation
        {
          key = "<C-H>"; # Ctrl + H
          mode = "n";
          silent = true;
          action = "<C-w>h"; # Move to the left split
        }
        {
          key = "<C-L>"; # Ctrl + L
          mode = "n";
          silent = true;
          action = "<C-w>l"; # Move to the right split
        }
        {
          key = "<C-J>"; # Ctrl + J
          mode = "n";
          silent = true;
          action = "<C-w>j"; # Move to the split below
        }
        {
          key = "<C-K>"; # Ctrl + K
          mode = "n";
          silent = true;
          action = "<C-w>k"; # Move to the split above
        }

        # Window dimensions
        {
          key = "<C-S-H>"; # Ctrl + Shift + H
          mode = "n";
          silent = true;
          action = ":vertical resize -2<CR>"; # Shrink horizontally
        }
        {
          key = "<C-S-L>"; # Ctrl + Shift + L
          mode = "n";
          silent = true;
          action = ":vertical resize +2<CR>"; # Expand horizontally
        }
        {
          key = "<C-S-J>"; # Ctrl + Shift + J
          mode = "n";
          silent = true;
          action = ":resize -2<CR>"; # Shrink vertically
        }
        {
          key = "<C-S-K>"; # Ctrl + Shift + K
          mode = "n";
          silent = true;
          action = ":resize +2<CR>"; # Expand vertically
        }
      ];
    };
  };
}
