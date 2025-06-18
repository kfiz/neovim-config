{
  description = "A nixvim configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    beacon = {
      url = "github:DanilaMihailov/beacon.nvim";
      flake = false;
    };
  };

  outputs =
    inputs:
    with inputs;
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;
      imports = [
        # Import nixvim's flake-parts module;
        # Adds `flake.nixvimModules` and `perSystem.nixvimConfigurations`
        nixvim.flakeModules.default
        treefmt-nix.flakeModule
        home-manager.flakeModules.home-manager
      ];

      nixvim = {
        # Automatically install corresponding packages for each nixvimConfiguration
        # Lets you run `nix run .#<name>`, or simply `nix run` if you have a default
        packages.enable = true;
        # Automatically install checks for each nixvimConfiguration
        # Run `nix flake check` to verify that your config is not broken
        checks.enable = true;
      };

      # You can define your reusable Nixvim modules here
      flake = {
        nixvimModules = {
          default = ./config/package;
        };
        homeModules.default = { pkgs, ... }: {
          imports = [
            (import ./config/general.nix { inherit pkgs inputs;})
            (import ./config/home { inherit inputs; })
          ];
        };
        nixosModules.default = { pkgs, ... }: {
          imports = [
            (import ./config/general.nix { inherit pkgs inputs; })
            (import ./config/nixos { inherit inputs; })
          ];
        };
      };

      perSystem =
        { system, ... }:
        {
          # You can define actual Nixvim configurations here
          nixvimConfigurations = {
            default = nixvim.lib.evalNixvim {
              inherit system;
              modules = [
                self.nixvimModules.default
              ];
              extraSpecialArgs = { inherit inputs; };
            };
          };
          treefmt.programs.nixfmt.enable = true;
        };
    };
}
