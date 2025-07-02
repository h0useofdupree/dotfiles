{python3Packages}:
python3Packages.buildPythonApplication {
  pname = "speakerctl";
  version = "1.0.0";

  format = "other";

  src = ./.;

  propagatedBuildInputs = [python3Packages.tinytuya];

  installPhase = ''
    mkdir -p $out/bin
    install -m755 main.py $out/bin/speakerctl
  '';

  doCheck = false;
}
