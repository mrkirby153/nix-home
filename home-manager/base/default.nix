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
  };
}
