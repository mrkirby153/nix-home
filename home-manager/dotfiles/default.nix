{
  config,
  pkgs,
  lib,
  my-dotfiles,
  ...
}@inputs: let
  discord-dotfiles = pkgs.callPackage ./discord.nix {inherit (inputs) discord-dotfiles;};
  dotfiles =
    (import ../../lib/dotfile-scripts {
      inherit pkgs;
      inherit my-dotfiles;
    })
    .derivations;
in {
  options.aus.programs.dotfiles.enable = lib.mkEnableOption "Enable dotfiles";

  config = lib.mkIf config.aus.programs.dotfiles.enable {
    home.packages =
      if config.aus.work
      then [discord-dotfiles]
      else dotfiles;
  };
}
