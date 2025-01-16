{pkgs, ...}: {
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    #vim-be-good
    #glow-nvim # Glow inside of Neovim
    #clipboard-image-nvim
  ];
  #    ++ [
  #      (pkgs.vimUtils.buildVimPlugin {
  #      pname = "markview.nvim";
  #      version = "0.0.1";
  #      src = pkgs.fetchFromGitHub {
  #        owner = "OXY2DEV";
  #        repo = "markview.nvim";
  #        rev = "a959d77ca7e9f05175e3ee4e582db40b338c9164";
  #        hash = "sha256-w6yn8aNcJMLRbzaRuj3gj4x2J/20wUROLM6j39wpZek=";
  #      };
  #    })
  #      # Just copy this block for a new plugin
  #      # (pkgs.vimUtils.buildVimPlugin {
  #      #   pname = "";
  #      #   src = pkgs.fetchFromGitHub {
  #      #     owner = "";
  #      #     repo = "";
  #      #     rev = "";
  #      #     sha256 = "";
  #      #   };
  #      # })
  #    ];
}
