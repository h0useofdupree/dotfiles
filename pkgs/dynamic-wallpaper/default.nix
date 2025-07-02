{stdenvNoCC}:
stdenvNoCC.mkDerivation {
  pname = "dynamic-wallpaper";
  version = "1.0.0";

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    install -m755 dynamic-wallpaper.sh $out/bin/dynamic-wallpaper
  '';
}
