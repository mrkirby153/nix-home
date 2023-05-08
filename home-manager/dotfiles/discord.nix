{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "discord_dotfiles";
  version = "0.0.1";
  src = builtins.fetchGit {
    url = "ssh://git@github.com/mrkirby153/discord_dotfiles.git";
    rev = "9c0a1df854dc9b00ec6172c196f40d69fd5572aa";
  };
  phases = ["installPhase" "fixupPhase"];
  installPhase = ''
    mkdir -p $out/bin
    cp -rf $src/bin/* $out/bin
  '';
  inputs = with pkgs; [bash];
}
