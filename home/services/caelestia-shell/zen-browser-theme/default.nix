{
  pkgs,
  config,
  ...
}: let
  # 1. Create a wrapped version of app.fish that includes its dependencies
  caelestia-native-app = pkgs.writeShellScriptBin "caelestiafox" ''
    export PATH="${pkgs.lib.makeBinPath [pkgs.fish pkgs.jq pkgs.inotify-tools]}:$PATH"
    exec fish ${./app.fish} "$@"
  '';

  # 2. Read the manifest and replace the placeholder with the store path
  manifest-content = builtins.fromJSON (builtins.readFile ./manifest.json);
  final-manifest =
    manifest-content
    // {
      path = "${caelestia-native-app}/bin/caelestiafox";
    };
in {
  home.file = {
    # Existing userChrome.css link
    ".zen/m5afri4k.default/chrome/userChrome.css".source = ./userChrome.css;

    # Declaratively write the JSON with the dynamic store path
    ".mozilla/native-messaging-hosts/caelestiafox.json".text = builtins.toJSON final-manifest;
  };
}
