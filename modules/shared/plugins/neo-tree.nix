let
  mod = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>n";
        action = ":Neotree action=focus reveal toggle<CR>";
        options.silent = true;
      }
    ];

    plugins.neo-tree = {
      enable = true;

      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = true;
      };
    };
  };
in
{
  flake.modules.homeManager.editors.programs.nixvim = mod;
  flake.modules.nixos.editors.programs.nixvim = mod;
  flake.modules.generic.package = mod;
}
