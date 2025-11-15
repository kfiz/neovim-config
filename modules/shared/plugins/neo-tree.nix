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

      settings = {
        close_if_last_window = true;
        window = {
          width = 30;
          auto_expand_width = true;
        };

      };
    };
  };
in
{
  flake.modules.homeManager.default.programs.nixvim = mod;
  flake.modules.nixos.default.programs.nixvim = mod;
  flake.modules.generic.package = mod;
}
