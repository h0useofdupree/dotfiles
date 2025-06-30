{
  buildPythonApplication,
  python3Packages,
}:
buildPythonApplication {
  pname = "speakerctl";
  version = "1.0.0";

  src = ./.;

  propagatedBuildInputs = [python3Packages.tinytuya];

  installPhase = ''
    mkdir -p $out/bin
    install -m755 main.py $out/bin/speakerctl
  '';
}
