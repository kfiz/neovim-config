let
  mod =
    { lib, ... }:
    {
      globals = {
        mapleader = ",";
        maplocalleader = ",";
      };

      keymaps =
        let
          insert = [
            {
              mode = "i";
              key = "jj";
              action = "<ESC>";
            }
          ];
          normal =
            lib.mapAttrsToList
              (key: action: {
                mode = "n";
                inherit action key;
              })
              {
                "<BS>" = "dh";
                "q" = ":q<CR>";
                "<CR>" = ":noh<CR><ESC>";
                "<leader><leader>" = ":lua require('beacon').highlight_cursor()<CR>";
                "n" = "n:lua require('beacon').highlight_cursor()<CR>";
                "N" = "N:lua require('beacon').highlight_cursor()<CR>";
                "*" = "*:lua require('beacon').highlight_cursor()<CR>";
                "#" = "#:lua require('beacon').highlight_cursor()<CR>";

                # back and fourth between the two most recent files
                "<C-c>" = ":b#<CR>";

                # close by Ctrl+x
                "<C-x>" = ":close<CR>";

                # save by ,+s or Ctrl+s
                "<leader>s" = ":w<CR>";
                "<C-s>" = ":w<CR>";

                # navigate to left/right window
                "<leader>h" = "<C-w>h";
                "<leader>l" = "<C-w>l";

                # Press 'H', 'L' to jump to start/end of a line (first/last character)
                L = "$";
                H = "^";

                # resize with arrows
                "<C-Up>" = ":resize -2<CR>";
                "<C-Down>" = ":resize +2<CR>";
                "<C-Left>" = ":vertical resize +2<CR>";
                "<C-Right>" = ":vertical resize -2<CR>";

                # move current line up/down
                # M = Alt key
                "<M-k>" = ":move-2<CR>";
                "<M-j>" = ":move+<CR>";

              };
          visual =
            lib.mapAttrsToList
              (key: action: {
                mode = "v";
                inherit action key;
              })
              {
                # better indenting
                ">" = ">gv";
                "<" = "<gv";
                "<TAB>" = ">gv";
                "<S-TAB>" = "<gv";

                # move selected line / block of text in visual mode
                "K" = ":m '<-2<CR>gv=gv";
                "J" = ":m '>+1<CR>gv=gv";

                # sort
                "<leader>s" = ":sort<CR>";
              };
        in
        lib.nixvim.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual ++ insert);
    };
in
{
  flake.modules.homeManager.editors.programs.nixvim = mod;
  flake.modules.nixos.editors.programs.nixvim = mod;
  flake.modules.generic.package = mod;
}
