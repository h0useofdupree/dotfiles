{stdenvNoCC}:
stdenvNoCC.mkDerivation {
  pname = "dynamic-wallpaper";
  version = "1.1.0";

  src = ./.;
  wallpapers = ../../lib/wallpapers/Mojave;

  patchPhase = ''
    substituteAllInPlace dynamic-wallpaper.sh
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -m755 dynamic-wallpaper.sh $out/bin/dynamic-wallpaper
  '';

  meta.mainProgram = "dynamic-wallpaper";
}
