{
  programs.nvf.settings.vim.keymaps = [
    {
      key = "zR";
      mode = "n";
      silent = true;
      action = "<cmd>lua require('ufo').openAllFolds()<CR>";
      desc = "Open all folds";
    }
    {
      key = "zM";
      mode = "n";
      silent = true;
      action = "<cmd>lua require('ufo').closeAllFolds()<CR>";
      desc = "Close all folds";
    }
    {
      key = "zr";
      mode = "n";
      silent = true;
      action = "<cmd>lua require('ufo').openFoldsExceptKinds()<CR>";
      desc = "Open folds except certain kinds";
    }
    {
      key = "zm";
      mode = "n";
      silent = true;
      action = "<cmd>lua require('ufo').closeFoldsWith()<CR>";
      desc = "Close folds with count (0 = all)";
    }
    {
      key = "K";
      mode = "n";
      silent = true;
      action = "<cmd>lua local winid = require('ufo').peekFoldedLinesUnderCursor(); if not winid then vim.lsp.buf.hover() end<CR>";
      desc = "Peek folded lines or hover";
    }
  ];
}
