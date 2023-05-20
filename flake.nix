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
    flake-utils.url = "flake-utils";

    my-dotfiles = {
      url = "github:mrkirby153/dotfiles";
      flake = false;
    };
    discord-dotfiles = {
      url = "git+ssh://git@github.com/mrkirby153/discord_dotfiles";
      flake = false;
    };
  };

  outputs = {
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
      }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${arch}.extend (self: super: {
            aus = my-nixpkgs.outputs.packages.${arch};
          });

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
        "archlinux" = mkSystem {name = "archlinux";};
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
