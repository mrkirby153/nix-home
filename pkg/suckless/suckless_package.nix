{
  pkgs,
  name,
  extraDeps ? [],
  preBuild ? "",
  ...
}: let
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
    buildInputs = with pkgs;
      [
        pkg-config
        xorg.libX11
        xorg.libXft
      ]
      ++ extraDeps;
    makeFlags = ["DESTDIR=$(out)" "PREFIX="];
    patchPhase = ''
      pushd source
      for patch in ../patches/*; do
        echo "Applying patch $patch"
        patch -p1 < $patch
      done
      popd
      if [ -f config.h ]; then
        echo "Copying configuration"
        cp config.h source/config.h
      fi
    '';
    buildPhase =
      preBuild
      + ''
        cd source
        make
      '';
  }
