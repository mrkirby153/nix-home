{pkgs}: let
  gitRepo = pkgs.fetchgit {
    url = "https://github.com/mrkirby153/dotfiles";
    rev = "28760c57b1764d93f025d1e75256f5732c2d6f69";
    sha256 = "sha256-VxRR9qa+A5SEBxgDLEAzehyNiFm/PLghrJjR8oPYv9o=";
  };
  source = "${gitRepo}/.local/bin";
  loadScripts = (import ./discover_files.nix {inherit pkgs;}).loadScripts;

  scripts = loadScripts source;

  # Create a derivations from each script
  makeScriptDerivation = path: deps:
    pkgs.stdenv.mkDerivation {
      name = "dotfiles-${path}";
      src = source + "/${path}";
      phases = ["installPhase" "fixupPhase"];
      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/${path}
        chmod +x $out/bin/${path}
      '';
      inputs = deps;
    };
  allScripts = pkgs.lib.mapAttrs (script: deps: makeScriptDerivation script deps) scripts;
  allDerivations = builtins.attrValues allScripts;
in {
  dotfiles = allScripts;
  derivations = allDerivations;
}
