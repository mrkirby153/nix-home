{ config, pkgs, lib, ... }:
let
  discord-dotfiles = pkgs.callPackage ./discord.nix { };
  dotfiles = (import ../../lib/dotfile-scripts { inherit pkgs; }).derivations;
in
{

  options.aus.programs.dotfiles.enable = lib.mkEnableOption "Enable dotfiles";

  config = lib.mkIf config.aus.programs.dotfiles.enable {
    home.packages = if config.aus.work then [discord-dotfiles] else dotfiles;
  };
}
