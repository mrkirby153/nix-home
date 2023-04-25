{
  description = "Home manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwmblocks.url = "github:mrkirby153/dwmblocks";
    rnix-lsp.url = "github:nix-community/rnix-lsp";
  };

  outputs = { self, nixpkgs, home-manager, dwmblocks, rnix-lsp, ... }: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

    homeConfigurations = {
      "aus-box" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        modules = [ ./home.nix ./dwm.nix ];

        extraSpecialArgs = {
          inherit dwmblocks;
          inherit rnix-lsp;
          username = "austin";
        };
      };
    };
  };
}
