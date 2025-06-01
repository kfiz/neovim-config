{
  description = "A nixvim configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    nixvim = {
      url = "github:nix-community/nixvim";
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
        inputs.nixvim.flakeModules.default
        inputs.treefmt-nix.flakeModule
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
      flake.nixvimModules = {
        default = ./config;
      };

      perSystem =
        { system, ... }:
        {
          # You can define actual Nixvim configurations here
          packages = {
            default = inputs.nixvim.legacyPackages."${system}".makeNixvimWithModule {
              module = self.nixvimModules.default;
              extraSpecialArgs = { inherit inputs; };
            };
          };
          treefmt.programs.nixfmt.enable = true;
        };
    };
}
