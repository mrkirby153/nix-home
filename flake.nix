{
  description = "Home manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwmblocks = {
      url = "github:mrkirby153/dwmblocks";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "flake-utils";
  };

  outputs = {
    nixpkgs,
    home-manager,
    flake-utils,
    ...
  } @ inputs: let
    # Define overlay
    overlay = self: super: {
      aus = import ./pkg {pkgs = super;};
    };
  in
    flake-utils.lib.eachDefaultSystem (system: {
      defaultPackage = home-manager.defaultPackage.${system};
    })
    // rec {
      mkSystem = {
        name,
        arch ? "x86_64-linux",
        extraModules ? [],
        extraArgs ? {},
      }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${arch}.extend overlay;

          modules =
            [
              ./hosts/${name}/configuration.nix
              ./home-manager
            ]
            ++ extraModules;
          extraSpecialArgs = inputs // extraArgs;
        };

      homeConfigurations = {
        "aus-box" = mkSystem {name = "aus-box";};
        "austinwhyte" = mkSystem {name = "coder";};
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter = pkgs.alejandra;
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          cacert
          curl
          jq

          nix-output-monitor
        ];
      };
    });
}
