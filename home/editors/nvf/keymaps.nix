_: {
  programs.nvf = {
    settings = {
      vim.keymaps = [
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
      ];
    };
  };
}
