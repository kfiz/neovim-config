{ lib, ... }:
{
  programs.nixvim = import ../../package/plugins/conform.nix;
}
