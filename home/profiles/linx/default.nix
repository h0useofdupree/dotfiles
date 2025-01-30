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

    # Media services
    ../../services/media/playerctl.nix

    # System Services
    ../../services/ags/default.nix
    ../../services/system/gnome-keyring.nix
    ../../services/system/kdeconnect.nix
    ../../services/system/polkit-agent.nix
    ../../services/system/theme.nix
    ../../services/system/udiskie.nix

    # Wayland services
    ../../services/wayland/gammastep.nix
    ../../services/wayland/hypridle.nix
    ../../services/wayland/hyprpaper.nix

    # Terminal emulators
    ../../terminal/emulators/kitty.nix
    ../../terminal/emulators/alacritty.nix
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 1920x1200@60, auto, 1"
      ", preferred, auto, 1"
      ", preferred, auto, 1, mirror, eDP-1"
    ];
  };
}
