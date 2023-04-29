{ pkgs }:
let
  lib = pkgs.lib;
in
{
  loadScripts = rawPath:
    let
      inherit (builtins) path readDir filter readFile;
      inherit (lib.attrsets) filterAttrs;
      inherit (lib.strings) isString split removePrefix;
      inherit (lib.lists) flatten;

      isFile = (name: type: type == "regular");
      files = filterAttrs isFile (readDir rawPath);
      getDependencies = file:
        let
          contents = filter isString (split "\n" (readFile file));
          isDependencyLine = (line: lib.strings.hasPrefix "#@" line);
          dependencyLines = filter isDependencyLine contents;
          rawDeps = map (removePrefix "#@ ") dependencyLines;
          deps = flatten (map (split ",") rawDeps);
        in
        map (dep: pkgs.${dep}) deps;
    in
    lib.mapAttrs (name: _type: getDependencies (rawPath + "/${name}")) files;
}
