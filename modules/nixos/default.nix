{ inputs, ... }:
{
  flake.modules.nixos.default = {
    imports = [
      inputs.nixvim.nixosModules.nixvim
    ];
  };
}
