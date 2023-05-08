{
  pkgs,
  my-dotfiles,
}: let
  source = "${my-dotfiles}/.local/bin";
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
