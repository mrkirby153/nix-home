{ pkgs, graphical, ... }@input:
let
  dwmblocks = input.dwmblocks.outputs.packages.x86_64-linux.default;
in
{

  # Only include if graphical
  home.packages = with pkgs.aus.suckless; if graphical then [
    dwmblocks
    st
    dwm
    dmenu
  ] else [ ];
}
