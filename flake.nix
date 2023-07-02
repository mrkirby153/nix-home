{
  description = "Home manager configuration";

  nixConfig = {
    extra-trusted-public-keys = "cache.mrkirby153.com:FUmgThcD58ed1M7MNOXWx7vC2ebnFqrc3gVgsqdNXJ0=";
    extra-substituters = "https://cache.mrkirby153.com";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-nixpkgs = {
      url = "github:mrkirby153/nix-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "flake-utils";

    my-dotfiles = {
      url = "github:mrkirby153/dotfiles";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    my-nixpkgs,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: {
      defaultPackage = home-manager.defaultPackage.${system};
    })
    // rec {
      mkSystem = {
        name,
        arch ? "x86_64-linux",
        extraModules ? [],
        extraArgs ? {},
      }: let
        pkgs = import nixpkgs {
          system = arch;
          overlays = [my-nixpkgs.overlays.default];
        };
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
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
        "archlinux" = mkSystem {name = "archlinux";};
      };
      hydraJobs = import ./hydra.nix { inherit inputs; outputs = self.outputs; };
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
