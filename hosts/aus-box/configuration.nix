{...}: {
  config.aus = {
    username = "austin";
    graphical = true;
    programs = {
      suckless.enable = false;
      #   vim.enable = true;
      dotfiles.enable = false;
    };
    nix = {
      enable = true;
    };
  };
}
