let
  mod =
    { pkgs, inputs, ... }:
    {
      programs.nixvim = {
        enable = true;
        wrapRc = true;
        defaultEditor = true;
        extraPlugins =
          let
            beacon = pkgs.vimUtils.buildVimPlugin {
              name = "beacon.nvim";
              src = inputs.myNeovim.inputs.beacon;
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
    };
in
{
  flake.modules.nixos.default = mod;
  flake.modules.homeManager.default = mod;
}
