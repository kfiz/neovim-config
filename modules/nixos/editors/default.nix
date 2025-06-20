{ inputs, ... }:
{
  flake.modules.nixos.editors = {
    imports = [
      inputs.nixvim.nixosModules.nixvim
    ];
  };
}
