{ pkgs, name, extraDeps ? [ ], preBuild ? "", ... }:
let
  inherit (pkgs) stdenv;
  repoBase = pkgs.fetchgit {
    url = "https://github.com/mrkirby153/suckless";
    rev = "ddba7b3650faeb44713af92617252f3ec3a02f29";
    sha256 = "sha256-NIFSjU6IxOsGcXPp7j7GK75/G/x19q7T+krXsyGujCI=";
    fetchSubmodules = true;
  };
in
stdenv.mkDerivation rec {
  inherit name;
  src = "${repoBase}/${name}";
  buildInputs = with pkgs; [
    pkg-config
    xorg.libX11
  ] ++ extraDeps;
  makeFlags = [ "DESTDIR=$(out)" "PREFIX=" ];
  patchPhase = ''
    sed -i 's|git|#git|g' setup.sh
    ${pkgs.bash}/bin/sh setup.sh
  '';
  buildPhase = preBuild + ''
    cd source
    make
  '';
}
