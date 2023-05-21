{
  pkgs,
  lib,
  config,
  ...
}: {
  options.aus.nix = {
    enable = lib.mkEnableOption "Enable nix configuration";
    cachix = lib.mkEnableOption "Install cachix";
  };

  imports = [
    ./cache.nix
  ];

  config = lib.mkIf config.aus.nix.enable {
    nix.package = pkgs.nix;
    nix.settings = {
      extra-experimental-features = lib.mkForce ["flakes" "nix-command"];
    };
    home.packages =
      if config.aus.nix.cachix
      then [
        pkgs.haskellPackages.cachix_1_3_3 # Use 1.3.3 as the latest version is kinda buggy
      ]
      else [];
  };
}
