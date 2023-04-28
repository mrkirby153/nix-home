{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fzf
    gdu
    tig
    gh
    ripgrep
  ];
}
