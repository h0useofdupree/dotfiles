{
    pkgs,
    self,
    ...
}: {
    imports = [
        ./hyprland
        # TEMP: Remove waybar once HyprPanel (AGSv2) instructions for NixOS are done!!!
        ./waybar
        ./hyprlock.nix
        ./wlogout.nix
    ];

    home.packages = with pkgs; [
        grim
        slurp

        self.packages.${pkgs.system}.wl-ocr
        wl-clipboard
        wlr-randr
    ];

    # Wayland compat
    home.sessionVariables = {
        QT_QPA_PLATFORM =  "wayland";
        SDL_VIDEODRIVER = "wayland";
        XDG_SESSION_TYPE = "wayland";
    };
}
