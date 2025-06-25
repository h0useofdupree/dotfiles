{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # Icons
      material-symbols

      # Sans(Serif)
      libertinus
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      (google-fonts.override {fonts = ["Inter"];})

      # Monospace
      jetbrains-mono

      # Nerd-Fonts
      nerd-fonts.caskaydia-cove
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
    ];

    enableDefaultPackages = false;

    fontconfig.defaultFonts = {
      serif = ["Libertinus Serif"];
      sansSerif = ["Inter"];
      monospace = ["JetBrains Mono Nerd Font"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
