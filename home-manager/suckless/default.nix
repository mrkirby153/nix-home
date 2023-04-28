{ pkgs, graphical, ... }:
let
  inherit (pkgs) callPackage;
  st = callPackage ./st.nix { };
  dwm = callPackage ./dwm.nix { };
  dmenu = callPackage ./dmenu.nix { };
in
{

  # Only include if graphical
  home.packages = with pkgs; if graphical then [
    dwmblocks # Provided as a flake
    st
    dwm
    dmenu
  ] else [ ];
}
