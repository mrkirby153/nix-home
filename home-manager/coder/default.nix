{ config, pkgs, lib, ... }:
{
  options.aus.work = lib.mkEnableOption "If this is a work machine";

  config = lib.mkIf config.aus.work {
    home.packages = with pkgs; [
      fzf
      gdu
      tig
      gh
      ripgrep
      zoxide
    ];
  };
}
