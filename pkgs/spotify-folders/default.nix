{
  fetchurl,
  python3,
  writeShellApplication,
}: let
  pythonWithSnappy = python3.withPackages (ps: [ps.python-snappy]);
in
  writeShellApplication {
    name = "spotify-folders";
    runtimeInputs = [pythonWithSnappy];
    text = ''
      python3 ${fetchurl {
        url = "https://raw.githubusercontent.com/mikez/spotify-folders/refs/heads/master/folders.py";
        sha256 = "0ym61ryr85kipfn59dpsq81sd9azym1nzc7kxf7brz9dkhqvxpg3";
      }} "$@"
    '';
  }
