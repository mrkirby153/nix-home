{ pkgs, ...}: 
{
    home.packages = with pkgs; [
        dwmblocks
    ];
}