{config, ...}: {
  services.swww.enable = true;
  dynamicWallpaper = {
    enable = true;
    autoLight = false;
    startTime = "06:00";
    endTime = "23:00";
    refreshInterval = "5m";
    group = "ZorinMountain";
    currentLink = config.home.homeDirectory + "/.cache/dynamic-wallpaper/current";

    # NOTE: Available sets:
    # DesertSands
    # -> 5 images - Ultrawide
    # Mojave
    # -> 16 images - 4K
    # WaterHill
    # -> 2 images - 4K
    # Ocean
    # -> 2 images - 4K
    # ZorinMountain
    # -> 5 images - 5k
  };
}
