{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "h0useofdupree";
  home.homeDirectory = "/home/h0useofdupree";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    cascadia-code
    obsidian
    inputs.zen-browser.packages.${pkgs.system}.default
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  imports = [
  ];

  programs = {
  };
}
