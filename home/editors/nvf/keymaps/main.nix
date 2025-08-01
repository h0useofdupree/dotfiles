{
  programs.nvf.settings.vim.keymaps = [
    {
      key = "j";
      mode = [
        "n"
        "v"
      ];
      silent = true;
      expr = true;
      desc = "Move cursor down";
      action = "v:count == 0 ? 'gj' : 'j'";
    }
    {
      key = "k";
      mode = [
        "n"
        "v"
      ];
      silent = true;
      expr = true;
      desc = "Move cursor up";
      action = "v:count == 0 ? 'gk' : 'k'";
    }

    # Close buffer
    {
      key = "<leader>c";
      mode = "n";
      silent = true;
      action = ":bp <BAR> bd #<CR>";
      desc = "which_key_ignore";
    }

    {
      key = "<ESC>";
      mode = "n";
      silent = true;
      action = "<cmd>nohlsearch<CR>";
      desc = "Clear search highlights";
    }

    # Quit window
    {
      key = "<leader>q";
      mode = "n";
      silent = true;
      action = ":q<CR>";
      desc = "which_key_ignore";
    }

    # Force quit
    {
      key = "<C-q>";
      mode = "n";
      silent = true;
      action = ":q!<CR>";
      desc = "Force quit window";
    }

    # Save file
    {
      key = "<C-s>";
      mode = "n";
      silent = true;
      action = ":w<CR>";
      desc = "Save file";
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
    {
      key = "|";
      mode = "n";
      silent = true;
      action = ":Neotree reveal<CR>";
      desc = "Reveal current file in Neotree";
    }

    # Toggle Term
    {
      key = "<leader>T";
      mode = "n";
      silent = true;
      action = ":ToggleTerm direction=float<CR>";
      desc = "Toggle floating terminal";
    }

    # UI
    {
      key = "<leader>tt";
      mode = "n";
      silent = true;
      action = ":if &background ==# 'dark'<BAR>set background=light<BAR>else<BAR>set background=dark<BAR>endif<CR>";
      desc = "Toggle dark/light mode";
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

    # Window splits
    {
      key = "<leader>sv";
      mode = "n";
      silent = true;
      action = ":vsplit<CR>";
      desc = "Split window vertically";
    }
    {
      key = "<leader>sh";
      mode = "n";
      silent = true;
      action = ":split<CR>";
      desc = "Split window horizontally";
    }
    {
      key = "<leader>sx";
      mode = "n";
      silent = true;
      action = ":close<CR>";
      desc = "Close current split";
    }
    {
      key = "<leader>se";
      mode = "n";
      silent = true;
      action = "<C-w>=";
      desc = "Equalize split sizes";
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
      action = ":resize +2<CR>";
      desc = "Shrink split vertically";
    }
    {
      key = "<C-S-K>"; # Ctrl + Shift + K
      mode = "n";
      silent = true;
      action = ":resize -2<CR>";
      desc = "Expand split vertically";
    }

    # Spider-w
    {
      key = "w";
      mode = ["n" "o" "x"]; # Normal, Operator-pending, Visual modes
      silent = true;
      action = "<cmd>lua require('spider').motion('w')<CR>";
      desc = "Spider-w";
    }

    # Spider-e
    {
      key = "e";
      mode = ["n" "o" "x"]; # Normal, Operator-pending, Visual modes
      silent = true;
      action = "<cmd>lua require('spider').motion('e')<CR>";
      desc = "Spider-e";
    }

    # Spider-b
    {
      key = "b";
      mode = ["n" "o" "x"]; # Normal, Operator-pending, Visual modes
      silent = true;
      action = "<cmd>lua require('spider').motion('b')<CR>";
      desc = "Spider-b";
    }
  ];
}
