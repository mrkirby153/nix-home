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

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      # Define overlay
      overlay = (self: super: {
        aus = import ./pkg { pkgs = super; };
      });

      # Discover home-manager modules
      inherit (builtins) readDir;
      inherit (nixpkgs.lib) mapAttrs;
      inherit (nixpkgs.lib.attrsets) filterAttrs;

      isDir = (name: type: type == "directory");
      homeManagerModules = builtins.attrValues (mapAttrs (name: _value: ./home-manager/${name}) (filterAttrs isDir (readDir ./home-manager)));
    in
    rec {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
      defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;
      defaultPackage.aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;

      
      mkSystem = { name, arch }: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${arch}.extend overlay;

        modules = [
          ./hosts/${name}/configuration.nix
        ] ++ homeManagerModules;
        extraSpecialArgs = inputs;
      };

      homeConfigurations = {
        "aus-box" = mkSystem { name = "aus-box"; arch = "x86_64-linux"; };
        "austinwhyte" = mkSystem { name = "coder"; arch = "x86_64-linux";};
      };
    };
}
