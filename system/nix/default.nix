{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./nh.nix
    ./nixpkgs.nix
    ./substituters.nix
  ];

  environment.systemPackages = [pkgs.git];

  nix = let
    flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  in {
    package = pkgs.lix;

    # Pin registry to avoid downloading and evaling a new nixpkgs version every time?
    registry = lib.mapAttrs (_: v: {flake = v;}) flakeInputs;

    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "nix-command"
        "flakes"
        # "repl-flake"
      ];
      flake-registry = "/etc/nix/registry.json";

      # Performance / Networking
      cores = 0; # Default: "machine-specific"
      max-jobs = "auto"; # Default: 1
      http-connections = 50; # Default: 25
      stalled-download-timeout = 150; # Default: 300

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = ["root" "@wheel"];

      accept-flake-config = false;
    };
  };
}
