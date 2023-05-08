{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (builtins) readDir;
  inherit (lib) mapAttrs;
  inherit (lib.attrsets) filterAttrs;

  isDir = name: type: type == "directory";
  homeManagerModules = builtins.attrValues (mapAttrs (name: _value: ./${name}) (filterAttrs isDir (readDir ./.)));
in {
  imports = homeManagerModules;
}
