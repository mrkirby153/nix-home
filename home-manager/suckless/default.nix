{ pkgs, ... }:
let
  inherit (pkgs) callPackage;
in
{
  # {
  #   home.packages = with pkgs; [
  #     dwmblocks # Provided as a flake
  #     st
  #   ];
  # }
  st = callPackage ./st.nix { };
  # dwm = callPackage ./dwm.nix { };
}
