{...}: {
  config.aus = {
    username = "discord";
    work = true;
    programs = {
      dotfiles.enable = true;
    };
    nix = {
      enable = true;
    };
  };
}
