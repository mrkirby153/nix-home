{ pkgs, ... }:
let
  inherit (pkgs) callPackage;
  st = callPackage ./st.nix { };
  dwm = callPackage ./dwm.nix { };
  dmenu = callPackage ./dmenu.nix { };
in
{

  home.packages = with pkgs; [
    dwmblocks # Provided as a flake
    st
    dwm
    dmenu
  ];
}
