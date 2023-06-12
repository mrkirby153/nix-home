{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.aus.programs.vim.enable = lib.mkEnableOption "Enable vim configuration";

  config = lib.mkIf config.aus.programs.vim.enable {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      package = pkgs.aus.nvim;
    };
  };
}
