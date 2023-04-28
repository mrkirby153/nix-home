{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "dotfiles";
  version = "0.0.1";
  src = pkgs.fetchgit {
    url = "https://github.com/mrkirby153/dotfiles";
    rev = "28760c57b1764d93f025d1e75256f5732c2d6f69";
    sha256 = "sha256-VxRR9qa+A5SEBxgDLEAzehyNiFm/PLghrJjR8oPYv9o=";
  };
  phases = [ "installPhase" "fixupPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp -rf $src/.local/bin/* $out/bin
  '';
  inputs = with pkgs; [
    git
    bash
  ];
}
