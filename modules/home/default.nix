{ config, inputs, ... }:
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];
  flake.homeModules.default = config.flake.modules.homeManager.default;
  flake.modules.homeManager.default = {
    imports = [
      inputs.nixvim.homeModules.nixvim
    ];
  };
}
