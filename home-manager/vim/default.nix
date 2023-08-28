{
  pkgs,
  config,
  lib,
  nvim,
  ...
}: {
  options.aus.programs.vim.enable = lib.mkEnableOption "Enable vim configuration";

  config = lib.mkIf config.aus.programs.vim.enable {
    home.packages = [
      # Using the overlay doesn't work for some reason
      nvim.packages.${pkgs.system}.default
    ];
  };
}
