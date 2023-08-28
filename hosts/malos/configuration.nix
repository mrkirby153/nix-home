{...}: {
  config.aus = {
    username = "austin";
    graphical = true;
    programs = {
      suckless.enable = true;
      vim.enable = true;
    };
    nix = {
      enable = true;
      cachix = true;
    };
  };
}
