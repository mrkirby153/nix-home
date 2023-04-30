{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) callPackage;
in
{
  suckless = callPackage ./suckless { };
}
