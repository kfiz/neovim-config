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
        filesystem = {
          filtered_items = {
            hide_dotfiles = false;
            hide_hidden = false;

            never_show_by_pattern = [
              ".direnv"
              ".git"
            ];

            visible = true;
          };
        };

        follow_current_file = {
          enabled = true;
          leave_dirs_open = true;
        };
        window = {
          width = 30;
          auto_expand_width = true;
          mappings = {
            "<space>" = "none";
            "x" = "cut_to_clipboard";
            "c" = "copy_to_clipboard";
            "o" = "toggle_node";
            "l" = "focus_preview";
            "e" = {
              command = "toggle_preview";
              config = {
                use_float = true;
              };
            };
            "<C-b>" = {
              command = "scroll_preview";
              config.direction = 10;
            };
            "<C-f>" = {
              command = "scroll_preview";
              config.direction = -10;
            };
          };
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
