{ stdenv, pkgs }:

stdenv.mkDerivation {
    name = "dwmblocks";
    src = pkgs.fetchgit {
        url = "https://github.com/mrkirby153/dwmblocks.git";
        rev = "cc29859d3c10b3054df5a53a50ae8a137efdc9ab";
        sha256 = "sha256-oUcOX9DGJq6Imm3YoQJMw4T6RESfCJmc0G3YDVhlf8g=";
    };
    buildInputs = with pkgs; [ xorg.libX11 pkg-config ];
    makeFlags = [ "PREFIX=$(out)" ];
}