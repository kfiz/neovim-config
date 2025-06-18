{
  config,
  lib,
  ...
}:
{
  programs.nixvim = import ../package/keymappings.nix;
}
