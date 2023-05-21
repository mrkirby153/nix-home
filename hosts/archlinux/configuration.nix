{...}: {
  config.aus = {
    username = "austin";
    graphical = true;
    nix = {
      enable = true;
      cachix = true;
      cache.enable = true;
    };
  };
}
