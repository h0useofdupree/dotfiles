{lib, ...}: {
  programs.nvf.settings.vim.options = lib.mkOptionDefault {
    updatetime = 100; # Faster completion

    # Line numbers
    relativenumber = true; # Relative line numbers
    number = true; # Display the absolute line number of the current line
    hidden = true; # Keep closed buffer open in the background
    mouse = "a"; # Enable mouse control
    mousemodel = "extend"; # Mouse right-click extends the current selection
    splitbelow = true; # A new window is put below the current one
    splitright = true; # A new window is put right of the current one

    swapfile = false; # Disable the swap file
    modeline = true; # Tags such as 'vim:ft=sh'
    modelines = 100; # Sets the type of modelines
    undofile = true; # Automatically save and restore undo history
    incsearch = true; # Incremental search: show match for partly typed search command
    inccommand = "split"; # Search and replace: preview changes in quickfix list
    ignorecase = true; # Match both lower- and upper-case for lowercase queries
    smartcase = true; # Override 'ignorecase' if search query contains uppercase
    scrolloff = 8; # Number of screen lines to show around the cursor
    cursorline = false; # Highlight the screen line of the cursor
    cursorcolumn = false; # Highlight the screen column of the cursor
    signcolumn = "yes"; # Always show the signcolumn
    laststatus = 3; # When to use a status line for the last window
    fileencoding = "utf-8"; # File-content encoding for the current buffer
    termguicolors = true; # Enable 24-bit RGB color
    wrap = true; # Prevent text wrapping

    # Tab options
    tabstop = 2; # Number of spaces a <Tab> represents
    shiftwidth = 2; # Number of spaces for each (auto)indent
    expandtab = true; # Expand <Tab> to spaces in Insert mode
    autoindent = true; # Enable autoindenting

    textwidth = 0; # Disable automatic line-breaking on text width

    # Folding
    foldlevel = 300; # Folds deeper than this level are closed
  };
}
