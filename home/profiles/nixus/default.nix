{
  imports = [
    # Editors
    ../../editors/nixvim
    ../../editors/vscode
    ../../editors/neovide

    # Programs
    ../../programs
    ../../programs/games
    ../../programs/wayland

    # Media services
    ../../services/media/playerctl.nix

    # System Services
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
      "DP-1, 3440x1440@160, auto, 1"
      ", preferred, auto, 1"
    ];
  };
}
