{
  description = "Home manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwmblocks.url = "github:mrkirby153/dwmblocks";
  };

  outputs = { self, nixpkgs, home-manager, dwmblocks, ... }:
    let
      customPkgs = (self: super: {
        aus = import ./pkg { pkgs = super; };
      });
    in
    rec {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
      defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;
      defaultPackage.aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;

      # Linux configuration
      linux = { username, discord ? false, graphical ? true }: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux.extend customPkgs;

        modules = [ ./home.nix ] ++ (if discord then [ ./home-manager/coder ./home-manager/vim ./home-manager/dotfiles ] else [ ./home-manager/suckless ]);

        extraSpecialArgs = {
          inherit dwmblocks;
          inherit graphical;
          inherit username;
          inherit discord;
        };
      };

      # Darwin
      darwin = { username, discord ? false, arch }: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${arch}.extend customPkgs;

        modules = [ ./home.nix ];

        extraSpecialArgs = {
          inherit username;
          inherit discord;

          graphical = true;
        };
      };

      homeConfigurations = {
        "aus-box" = linux {
          username = "austin";
        };
        "austinwhyte" = linux {
          username = "discord";
          discord = true;
          graphical = false;
        };
      };
    };
}
