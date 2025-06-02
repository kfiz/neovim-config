{ pkgs, inputs, ... }:
{
  # Import all your configuration modules here
  imports = [
    inputs.nixvim.nixosModules.nixvim
    ../modules/plugins
    ../modules/completion.nix
    ../modules/options.nix
    ../modules/keymappings.nix
  ];
  programs.nixvim = {
    enable = true;
    # defaultEditor = true;
    extraPlugins =
      let
        beacon = pkgs.vimUtils.buildVimPlugin {
          name = "beacon.nvim";
          src = inputs.beacon;
        };
      in
      [ beacon ];
    extraConfigLua = "require('beacon').setup({enabled = true})";
    autoCmd = [
      {
        event = [ "BufReadPost" ];
        pattern = [ "*" ];
        command = ''
          if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
        '';
      }
    ];

    nixpkgs.useGlobalPackages = true;

    performance = {
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "nvim-treesitter"
        ];
      };
      byteCompileLua.enable = true;
    };

    # viAlias = true;
    # vimAlias = true;

    luaLoader.enable = true;
  };
}
