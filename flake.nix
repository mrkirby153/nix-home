{
  description = "Home manager configuration";

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
    nvim = {
      url = "github:mrkirby153/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "flake-utils";

    my-dotfiles = {
      url = "github:mrkirby153/dotfiles";
      flake = false;
    };
    attic = {
      url = "github:zhaofengli/attic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    my-nixpkgs,
    nvim,
    attic,
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
          overlays = [my-nixpkgs.overlays.default attic.overlays.default];
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
        "malos" = mkSystem {name = "malos";};
      };
      hydraJobs = import ./hydra.nix {
        inherit inputs;
        outputs = self.outputs;
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
      packages = let
        pkg = import ./pkg {inherit pkgs;};
      in {
        dwmblocks = pkg.dwmblocks;
      };
    });
}
