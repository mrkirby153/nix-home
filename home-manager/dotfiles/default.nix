{ pkgs, discord, ... }:
let
  dotfiles = pkgs.callPackage ./scripts.nix { };
  discord-dotfiles = pkgs.callPackage ./discord.nix { };
in
{
  home.packages = [
    (if discord then discord-dotfiles else dotfiles)
  ];
}
