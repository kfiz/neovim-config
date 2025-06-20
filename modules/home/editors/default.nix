{ inputs, ... }:
{
  flake.modules.homeManager.editors = {
    imports = [
      inputs.nixvim.homeModules.nixvim
    ];
  };
}
