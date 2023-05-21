{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in {
  options.aus = {
    username = lib.mkOption {
      type = lib.types.str;
      example = "austin";
      description = "The username!";
    };
  };

  config = {
    home.username = "${config.aus.username}";
    home.homeDirectory =
      if !isDarwin
      then "/home/${config.aus.username}"
      else "/Users/${config.aus.username}";
    home.stateVersion = "22.11";
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      httpie
      nix-prefetch-scripts
      nil
    ];

   nix.package = pkgs.nix;
   nix.settings = {
    extra-experimental-features = lib.mkForce [ "flakes" "nix-command" ];
    substituters = lib.mkForce [ "https://cache.nixos.org" "https://mrkirby153.cachix.org" ];
    trusted-public-keys = lib.mkForce [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "mrkirby153.cachix.org-1:3OAJDKkNWKVSipjFG6jwS5uBsMZ6lLKAEz18k2zKZjw=" ];
   };
  };
}
