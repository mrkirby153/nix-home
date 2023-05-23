{...}: {
  config.aus = {
    username = "austin";
    graphical = true;
    programs = {
      suckless.enable = true;
      #   vim.enable = true;
      dotfiles.enable = true;
    };
    nix = {
      enable = true;
      cachix = true;
      cache.enable = true;
    };
  };
}
