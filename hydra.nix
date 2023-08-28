{
  inputs,
  outputs,
}: let
  inherit (inputs.nixpkgs.lib) mapAttrs;
  getCfg = _: cfg: cfg.activationPackage;
in {
  hosts = mapAttrs getCfg outputs.homeConfigurations;
}
