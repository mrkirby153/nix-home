{
  config,
  pkgs,
  lib,
  my-dotfiles,
  ...
}: let
  dotfiles =
    (import ../../lib/dotfile-scripts {
      inherit pkgs;
      inherit my-dotfiles;
    })
    .derivations;
in {
  options.aus.programs.dotfiles.enable = lib.mkEnableOption "Enable dotfiles";

  config = lib.mkIf config.aus.programs.dotfiles.enable {
    home.packages = dotfiles;
  };
}
