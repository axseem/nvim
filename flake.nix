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
        ];
      };

      startupPlugins = with pkgs.vimPlugins; {
        general = [
          gitsigns-nvim
          which-key-nvim
          plenary-nvim
          telescope-nvim
          lazy-nvim

          (nvim-treesitter.withPlugins (
            plugins:
              with plugins; [
                bash
                c
                cpp
                css
                diff
                go
                gomod
                gosum
                html
                javascript
                json
                lua
                markdown
                markdown-inline
                nix
                rust
                svelte
                tsx
                typescript
                vim
                vimdoc
                zig
              ]
          ))

          blink-cmp

          conform-nvim
        ];
      };

      optionalPlugins = {
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
          hosts.python3.enable = false;
          hosts.node.enable = false;
        };

        categories = {
          general = true;
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

      devShells = {
        default = pkgs.mkShell {
          name = defaultPackageName;
          packages = [defaultPackage];
          inputFrom = [];
          shellHook = '''';
        };
      };
    });
}
