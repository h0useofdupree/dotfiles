{python3Packages}:
python3Packages.buildPythonApplication {
  pname = "caelestia-colors";
  version = "0.1.0";

  format = "other";
  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    install -m755 main.py $out/bin/caelestia-colors
  '';

  meta.mainProgram = "caelestia-colors";
  doCheck = false;
}
