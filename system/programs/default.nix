{
    imports = [
        ./fonts.nix
        ./home-manager.nix
        ./xdg.nix
    ];

    programs = {
        # Allow HM to manage GTK
        dconf.enable = true;

        kdeconnect.enable = true;
        
        # Key-management GUI for gnome-keyring
        seahorse.enable = true;
    };
}
