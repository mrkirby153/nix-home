{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.aus.graphical = lib.mkEnableOption "If this system is grpahical";
  options.aus.programs.suckless.enable = lib.mkEnableOption "Enable suckless packages";

  config = lib.mkIf (config.aus.graphical && pkgs.system == "x86_64-linux" && config.aus.programs.suckless.enable) {
    home.packages = with pkgs.aus.suckless; [
      dwmblocks
      st
      dwm
      dmenu
    ];
  };
}
