{ pkgs, inputs, ... }:
{
  # Import all your configuration modules here
  imports = [
    ./plugins
    ./completion.nix
    ./options.nix
    ./keymappings.nix
  ];
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
}
