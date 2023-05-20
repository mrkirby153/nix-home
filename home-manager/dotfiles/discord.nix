{
  pkgs,
  discord-dotfiles,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = "discord_dotfiles";
  version = "0.0.1";
  src = discord-dotfiles;
  phases = ["installPhase" "fixupPhase"];
  installPhase = ''
    mkdir -p $out/bin
    cp -rf $src/bin/* $out/bin
  '';
  inputs = with pkgs; [bash];
}
