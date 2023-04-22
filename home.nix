{ pkgs, ...}: 
let
    custom-pkgs = import ./pkgs { pkgs = pkgs; };
in
{
    home.username = "austin";
    home.homeDirectory = "/home/austin";
    home.stateVersion = "22.11";
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
        httpie
        nix-prefetch-scripts
    ];
}