{
  stdenvNoCC,
  installShellFiles,
}:
stdenvNoCC.mkDerivation {
  pname = "dynamic-wallpaper";
  version = "1.2.1";

  src = ./.;
  wallpapers = ../../lib/wallpapers;
  default_group = "Mojave";

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
