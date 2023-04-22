{ pkgs }:
let
    callPackage = pkgs.callPackage;
in
{
    dwmblocks = callPackage ./dwmblocks { };
}
