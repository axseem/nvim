{
  description = "axseem's neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixCats,
    ...
  } @ inputs: let
    inherit (nixCats) utils;
    luaPath = ./.;
    forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
    extra_pkg_config = {};

    dependencyOverlays = [
      (utils.standardPluginOverlay inputs)
    ];

    categoryDefinitions = {
      pkgs,
      settings,
      categories,
      extra,
      name,
      mkPlugin,
      ...
    } @ packageDef: {
      lspsAndRuntimeDeps = with pkgs; {
        general = [
          ripgrep
          fd
          lazygit
          wl-clipboard
          universal-ctags

          marksman
          lua-language-server
          nixd
          basedpyright
          rust-analyzer
          typescript-language-server
          svelte-language-server
          vscode-langservers-extracted
          zls

          alejandra
          stylua
          shfmt
          ruff
          rustfmt
          prettierd
          eslint_d
        ];
      };

      startupPlugins = with pkgs.vimPlugins; {
        gitPlugins = [];
        general = [
          todo-comments-nvim
          which-key-nvim
          gitsigns-nvim
          trouble-nvim
          render-markdown-nvim

          plenary-nvim
          telescope-nvim
          telescope-zf-native-nvim
          telescope-ui-select-nvim

          (nvim-treesitter.withPlugins (
            plugins:
              with plugins; [
                bash
                c
                corn
                cpp
                css
                csv
                diff
                dockerfile
                html
                javascript
                jsdoc
                json
                jsonc
                latex
                lua
                luadoc
                luap
                markdown
                markdown-inline
                nginx
                nix
                printf
                python
                query
                regex
                rust
                sql
                svelte
                toml
                tsx
                typescript
                vim
                vimdoc
                xml
                yaml
                zig
              ]
          ))

          blink-cmp
          friendly-snippets

          conform-nvim

          lazydev-nvim

          lualine-nvim

          snacks-nvim
          ts-comments-nvim

          smear-cursor-nvim

          mini-icons

          mini-pairs
        ];
      };

      optionalPlugins = {
        gitPlugins = [];
        general = [];
      };

      sharedLibraries = {
        general = [];
      };

      environmentVariables = {};

      extraWrapperArgs = {};
    };

    packageDefinitions = {
      neovim = {
        pkgs,
        name,
        ...
      }: {
        settings = {
          suffix-path = true;
          suffix-LD = true;
          wrapRc = true;
          aliases = ["nvim"];
          hosts.python3.enable = true;
          hosts.node.enable = true;
        };

        categories = {
          general = true;
          gitPlugins = true;
          customPlugins = true;
          test = true;
          formatters = true;
          colorscheme = "rose-pine-moon";
          nvim-gitsigns = true;
          have_nerd_font = true;
        };
      };
    };

    defaultPackageName = "neovim";
  in
    forEachSystem (system: let
      nixCatsBuilder =
        utils.baseBuilder luaPath {
          inherit nixpkgs system dependencyOverlays extra_pkg_config;
        }
        categoryDefinitions
        packageDefinitions;
      defaultPackage = nixCatsBuilder defaultPackageName;
      pkgs = import nixpkgs {inherit system;};
    in {
      packages = utils.mkAllWithDefault defaultPackage;

      devShell = {
        default = pkgs.mkShell {
          name = defaultPackageName;
          packages = [defaultPackage];
          inputFrom = [];
          shellHook = '''';
        };
      };
    });
}
