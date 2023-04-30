{ pkgs, graphical, ... }@input:
{

  # Only include if graphical
  home.packages = with pkgs.aus.suckless; if graphical then [
    input.dwmblocks # Provided as a flake
    st
    dwm
    dmenu
  ] else [ ];
}
