{
  stdenvNoCC,
  installShellFiles,
}:
stdenvNoCC.mkDerivation {
  pname = "dynamic-wallpaper";
  version = "1.2.0";

  src = ./.;
  wallpapers = ../../lib/wallpapers/Mojave;

  patchPhase = ''
    substituteAllInPlace dynamic-wallpaper.sh
  '';

  nativeBuildInputs = [installShellFiles];

  installPhase = ''
    mkdir -p $out/bin
    install -m755 dynamic-wallpaper.sh $out/bin/dynamic-wallpaper

    # TODO: Add bash/zsh completions
    installShellCompletion \
      --fish completions/dynamic-wallpaper.fish
  '';

  meta.mainProgram = "dynamic-wallpaper";
}
