{
  config,
  isLaptop,
  ...
}: let
  groupLinx = "AnimeCity";
  groupNixus = "Fuji";
in {
  services.swww.enable = true;
  dynamicWallpaper = {
    enable = true;
    autoLight = false;
    startTime = "06:00";
    endTime = "23:00";
    refreshInterval = "5m";
    group =
      if isLaptop
      then groupLinx
      else groupNixus;
    currentLink = config.home.homeDirectory + "/.cache/dynamic-wallpaper/current";

    # NOTE: Available groups:
    # - 'DesertSands' - 5 images - 5160x2160
    # - 'Fuji' - 7 images - 5719x3720
    # - 'Mojave' - 16 images - 5120x2880
    # - 'Ocean' - 2 images - 4096x2621
    # - 'WaterHill' - 2 images - 4096x2621
    # - 'ZorinMountain' - 5 images - 5760x3600
  };
}
