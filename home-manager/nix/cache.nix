{
  pkgs,
  config,
  lib,
  ...
}: {
  options.aus.nix.cache = {
    enable = lib.mkEnableOption "Enable mrkirby153.cachix.org";
  };

  config = lib.mkIf (config.aus.nix.cache.enable && config.aus.nix.enable) {
    nix.settings = {
      substituters = lib.mkForce ["https://cache.nixos.org" "https://mrkirby153.cachix.org"];
      trusted-public-keys = lib.mkForce ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "mrkirby153.cachix.org-1:3OAJDKkNWKVSipjFG6jwS5uBsMZ6lLKAEz18k2zKZjw="];
    };
  };
}
