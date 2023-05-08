{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (pkgs) vimUtils;
  inherit (vimUtils) buildVimPlugin;
  # Vim plugins not in nixpkgs

  vim-vaffle = buildVimPlugin {
    name = "vaffle";
    src = pkgs.fetchFromGitHub {
      owner = "cocopon";
      repo = "vaffle.vim";
      rev = "0a314644c38402b659482568525b1303f7d0e01d";
      sha256 = "sha256-CvV4OQ8LQVsZMnyPUDX4bWGqYTxUtTj1eH+Y+CwkEWQ=";
    };
  };
  vim-css3-syntax = buildVimPlugin {
    name = "vim-css3-syntax";
    src = pkgs.fetchFromGitHub {
      owner = "hail2u";
      repo = "vim-css3-syntax";
      rev = "d858def9c13c93b59752ed0f85030d8e66fba0ac";
      sha256 = "sha256-Kvu14LN4jrK32ncqJlGoc6ALEb5AEa9JFf0nEuz7aR4=";
    };
  };
  vim-coloresque = buildVimPlugin {
    name = "vim-coloresque";
    src = pkgs.fetchFromGitHub {
      owner = "gko";
      repo = "vim-coloresque";
      rev = "e12a5007068e74c8ffe5b1da91c25989de9c2081";
      sha256 = "sha256-b8EYF/CYhz6qDmhybNJUVyXmbSfEOap01wP4SwuANRY=";
    };
  };
  vim-haml = buildVimPlugin {
    name = "vim-haml";
    src =
      pkgs.fetchFromGitHub
      {
        owner = "tpope";
        repo = "vim-haml";
        rev = "95a095a4d29eaf0ba0851dcee5635053ec0f9f74";
        sha256 = "sha256-EebHAK/YMVzt1fiROVjBiuukRZLQgaCNNHqV2DBC3U4=";
      };
  };
in {
  options.aus.programs.vim.enable = lib.mkEnableOption "Enable vim configuration";

  config = lib.mkIf config.aus.programs.vim.enable {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-vaffle
        vim-surround
        vim-repeat
        conflict-marker-vim
        neosnippet
        neosnippet-snippets
        vim-snippets
        syntastic
        vim-fugitive
        webapi-vim
        vim-gist
        nerdcommenter
        vim-commentary
        tabular
        tagbar
        rainbow
        vim-highlightedyank
        python-mode
        vim-json
        vim-javascript
        typescript-vim
        vim-jsx-typescript
        vim-jsx-pretty
        vim-closetag
        vim-css3-syntax
        vim-coloresque
        vim-haml
        emmet-vim
        vim-markdown
        vim-toml
        vim-airline
        vim-airline-themes
      ];
      extraConfig = builtins.readFile ./annoyances.vim;
      extraLuaConfig = builtins.toString (builtins.map (x: builtins.readFile x + "\n") [./keymap.lua ./autocmd.lua]);
    };
  };
}
