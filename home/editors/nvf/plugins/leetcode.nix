{
  programs.nvf.settings.vim.utility = {
    leetcode-nvim = {
      enable = true;
      setupOpts = {
        arg = "leetcode.nvim";
        image_support = true;
        lang = "python3";
      };
    };

    # For leetcode-nvim image-support
    image-nvim = {
      enable = true;
      setupOpts = {
        backend = "kitty";
        integrations = {
          markdown = {
            enable = true;
            clearInInsertMode = false;
            downloadRemoteImages = false;
            filetypes = [
              "markdown"
              "vimwiki"
            ];
          };
          # TODO: Add for neorg if needed
        };
        hijackFilePatterns = [
          # NOTE: Default
          "*.png"
          "*.jpg"
          "*.jpeg"
          "*.gif"
          "*.webp"
        ];
      };
    };
  };
}
