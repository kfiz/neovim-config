{ inputs, ... }:
with inputs;
{
  imports = [
    # Import nixvim's flake-parts module;
    # Adds `flake.nixvimModules` and `perSystem.nixvimConfigurations`
    nixvim.flakeModules.default
  ];

  nixvim = {
    # Automatically install corresponding packages for each nixvimConfiguration
    # Lets you run `nix run .#<name>`, or simply `nix run` if you have a default
    packages.enable = true;
    # Automatically install checks for each nixvimConfiguration
    # Run `nix flake check` to verify that your config is not broken
    checks.enable = true;
  };
  perSystem =
    { system, ... }:
    {
      nixvimConfigurations = {
        default = nixvim.lib.evalNixvim {
          inherit system;
          modules = [
            self.modules.generic.package
          ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
