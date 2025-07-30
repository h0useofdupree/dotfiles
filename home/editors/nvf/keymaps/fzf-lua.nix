{
  programs.nvf.settings.vim.keymaps = [
    # prefix for all fzf-lua commands
    {
      key = "<leader>f";
      mode = "n";
      silent = true;
      action = "<Nop>";
      desc = "fzf-lua";
    }

    # find files
    {
      key = "<leader>ff";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').files()<CR>";
      desc = "Find files";
    }

    # live grep current project
    {
      key = "<leader>fg";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').live_grep()<CR>";
      desc = "Live grep";
    }

    # grep under cursor
    {
      key = "<leader>fw";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').grep_cword()<CR>";
      desc = "Grep word under cursor";
    }

    # recent files (history)
    {
      key = "<leader>fh";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').oldfiles()<CR>";
      desc = "Recent files";
    }

    # buffers
    {
      key = "<leader>fb";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').buffers()<CR>";
      desc = "Buffers";
    }

    # resume last picker
    {
      key = "<leader>fr";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').resume()<CR>";
      desc = "Resume last";
    }

    # git files
    {
      key = "<leader>fgf";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').git_files()<CR>";
      desc = "Git files";
    }

    # git status
    {
      key = "<leader>fgs";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').git_status()<CR>";
      desc = "Git status";
    }

    # help tags
    {
      key = "<leader>fhc";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').helptags()<CR>";
      desc = "Help tags";
    }

    # colorschemes
    {
      key = "<leader>fcs";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').colorschemes()<CR>";
      desc = "Colorschemes";
    }

    # commands history
    {
      key = "<leader>fhc";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').command_history()<CR>";
      desc = "Command History";
    }

    # global picker (files, buffers, symbols)
    {
      key = "<leader>fgp";
      mode = "n";
      silent = true;
      action = ":lua require('fzf-lua').global()<CR>";
      desc = "Global picker";
    }
  ];
}
