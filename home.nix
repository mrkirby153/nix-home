{ pkgs, username, ...}: 
let
    inherit (pkgs.stdenv.hostPlatform) isDarwin;
in
{
    home.username = "${username}";
    home.homeDirectory = if !isDarwin then "/home/${username}" else "/Users/${username}";
    home.stateVersion = "22.11";
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
        httpie
        nix-prefetch-scripts
    ];
}