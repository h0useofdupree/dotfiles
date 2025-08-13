{
  imports = [
    # Editors
    ../../editors/vscode
    ../../editors/neovide
    ../../editors/nvf

    # Programs
    ../../programs
    ../../programs/games
    ../../programs/wayland
    ./hyprland.nix

    # Media services
    ../../services/media/playerctl.nix

    # System Services
    ../../services/system/gnome-keyring.nix
    ../../services/system/kdeconnect.nix
    ../../services/system/polkit-agent.nix
    ../../services/system/theme.nix
    ../../services/system/udiskie.nix

    # Wayland services
    ../../services/caelestia-shell
    ../../services/wayland/gammastep.nix
    ../../services/wayland/hypridle.nix
    ../../services/wayland/hyprpaper.nix
    ../../services/wayland/dynamic-wallpaper.nix

    # Terminal emulators
    ../../terminal/emulators/kitty.nix
    ../../terminal/emulators/alacritty.nix
  ];
}
