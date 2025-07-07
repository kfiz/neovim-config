{ inputs, ... }:
{
  flake.modules.homeManager.default = {
    imports = [
      inputs.nixvim.homeModules.nixvim
    ];
  };
}
