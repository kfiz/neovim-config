{
  imports = [
    ./lsp.nix
    ./lualine.nix
    ./neo-tree.nix
    ./telescope.nix
    ./treesitter.nix
  ];
  programs.nixvim = ../../package/plugins/misc.nix;
}
