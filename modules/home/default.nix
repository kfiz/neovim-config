{ config, inputs, ... }:
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];
  flake.modules.homeManager.default = {
    imports = [
      inputs.nixvim.homeModules.nixvim
    ];
  };
  flake.homeModules.default = config.flake.modules.homeManager.default;
}
