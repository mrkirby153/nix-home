{ pkgs, ... }:
let
  dotfiles = pkgs.callPackage ./scripts.nix { };
in
{
  home.packages = [
    dotfiles
  ];
}
