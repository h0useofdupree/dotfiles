{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    homeImports = import "${self}/home/profiles";

    mod = "${self}/system";

    inherit (import mod) desktop laptop;

    specialArgs = {inherit inputs self;};
  in {
    nixus = nixosSystem {
      inherit specialArgs;

      modules =
        desktop
        ++ [
          ./nixus
          "${mod}/programs/gamemode.nix"
          "${mod}/programs/hyprland.nix"
          "${mod}/programs/games.nix"

          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"

          {
            home-manager = {
              users.h0useofdupree.imports = homeImports."h0useofdupree@nixus";
              extraSpecialArgs =
                specialArgs
                // {
                  isLaptop = false;
                };
              backupFileExtension = "hm-backup";
            };
          }

          inputs.agenix.nixosModules.default
          inputs.chaotic.nixosModules.default
        ];
    };

    linx = nixosSystem {
      inherit specialArgs;

      modules =
        laptop
        ++ [
          ./linx
          "${mod}/programs/gamemode.nix"
          "${mod}/programs/hyprland.nix"
          "${mod}/programs/games.nix"

          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"

          {
            home-manager = {
              users.h0useofdupree.imports = homeImports."h0useofdupree@linx";
              extraSpecialArgs =
                specialArgs
                // {
                  isLaptop = true;
                };
              backupFileExtension = "hm-backup";
            };
          }

          inputs.agenix.nixosModules.default
          inputs.chaotic.nixosModules.default
        ];
    };
  };
}
