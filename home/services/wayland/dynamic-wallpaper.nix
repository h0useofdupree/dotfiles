{config, ...}: {
  services.swww.enable = false;
  dynamicWallpaper = {
    enable = false;
    autoLight = false;
    startTime = "06:00";
    endTime = "23:00";
    refreshInterval = "5m";
    group = config.home.homeDirectory + "/.local/share/dynamic-wallpapers/Mojave";
    currentLink = config.home.homeDirectory + "/.cache/dynamic-wallpaper/current";

    # NOTE: Favorites
    # - DesertSands - 5 images - Ultrawide
    # - Mojave - 16 images - 4K
    # - WaterHill - 2 images - 4K
    # - Ocean - 2 images - 4K
  };
}
