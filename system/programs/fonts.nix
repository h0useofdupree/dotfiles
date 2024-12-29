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
            nerd-fonts.symbols-only
        ];

        enableDefaultPackages = false;
    };
}
