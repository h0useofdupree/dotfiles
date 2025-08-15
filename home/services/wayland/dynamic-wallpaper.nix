{
  config,
  isLaptop,
  ...
}: let
  groupLinx = "AnimeCity";
  groupNixus = "SillyWalker";
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
    # - 'Alps' - 19 images - 5120x2880 - avg #7C8DB6 - ~60% bright
    # - 'AnimeCity' - 96 images - 5120x2880 - avg #7C9FB8 - ~61% bright
    # - 'Atacama' - 9 images - 5120x3406 - avg #5D7685 - ~45% bright
    # - 'Beach' - 9 images - 6016x6016 - avg #5F8778 - ~45% bright
    # - 'Burnaby' - 8 images - 5120x2880 - avg #50413D - ~27% bright
    # - 'Catalina' - 9 images - 6016x6016 - avg #504D5E - ~33% bright
    # - 'Colors' - 23 images - 5760x4096 - avg #011C3E - ~12% bright
    # - 'Dome' - 2 images - 6016x6016 - avg #A7968E - ~59% bright
    # - 'Earth' - 16 images - 5120x2880 - avg #070707 - ~3% bright
    # - 'Exodus' - 4 images - 5120x2880 - avg #98878B - ~54% bright
    # - 'Fletschhorn' - 6 images - 5174x3266 - avg #477FBA - ~49% bright
    # - 'Fuji' - 7 images - 5719x3720 - avg #88949A - ~55% bright
    # - 'Hachioji' - 13 images - 6000x4000 - avg #8A8479 - ~51% bright
    # - 'MinimalForest' - 4 images - 3840x2160 - avg #33576A - ~29% bright
    # - 'Monterey' - 16 images - 6048x3402 - avg #707B92 - ~49% bright
    # - 'PangongTso' - 5 images - 5519x3104 - avg #122641 - ~16% bright
    # - 'Plants' - 3 images - 3840x2160 - avg #484A68 - ~31% bright
    # - 'SillyWalker' - 17 images - 5120x2880 - avg #83A9B2 - ~63% bright
    # - 'Sur' - 8 images - 6016x6016 - avg #3F5A6E - ~34% bright
    # - 'TechFactory' - 5 images - 5120x2880 - avg #17181A - ~9% bright
    # - 'Tropics' - 18 images - 5120x2880 - avg #25342A - ~17% bright
  };
}
