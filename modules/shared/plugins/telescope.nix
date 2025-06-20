let
  mod = {
    plugins.telescope = {
      enable = true;

      keymaps = {
        # Find files using Telescope command-line sugar.
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
        "<leader>fh" = "help_tags";
        "<leader>fd" = "diagnostics";

        # FZF like bindings
        "<C-p>" = "git_files";
        "<leader>p" = "oldfiles";
        "<C-f>" = "live_grep";
      };

      settings = {
        defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.jj/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "%.ipynb"
          ];
          set_env.COLORTERM = "truecolor";
        };
      };
    };

    highlightOverride =
      let
        custom = {
          fg = "#93a1a1";
          # fg = "#06303b";
          # bg = "#859900";
        };
      in
      {
        TelescopeBorder.fg = "#93a1a1";
        TelescopePromptNormal.fg = "#93a1a1";
        TelescopePromptBorder.fg = "#93a1a1";
        TelescopePromptPrefix.fg = "#dc322f";
        TelescopePromptTitle = custom;
        TelescopeResultsTitle = custom;
        TelescopePreviewTitle = custom;
      };
    # Find TODOs
    keymaps = [
      {
        mode = "n";
        key = "<C-t>";
        action.__raw = ''
          function()
            require('telescope.builtin').live_grep({
              default_text="TODO",
              initial_mode="normal"
            })
          end
        '';
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>cp";
        action.__raw = ''
                  function()
            local util = require("lspconfig.util")  -- or use your own root finder logic
            local root = util.root_pattern(".git", "lua", "package.json")(vim.fn.expand("%:p")) or vim.fn.getcwd()

            root = vim.fn.fnamemodify(root, ":p")  -- Normalize to absolute path

            if vim.fn.isdirectory(root) == 1 then
              vim.cmd("cd " .. vim.fn.fnameescape(root))
              vim.notify("Changed directory to project root: " .. root, vim.log.levels.INFO)
              require("telescope.builtin").find_files({ cwd = root })
            else
              vim.notify("Invalid root directory: " .. root, vim.log.levels.ERROR)
            end
          end,
          { desc = "Jump to project root and open Telescope" }
        '';
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>cf";
        action.__raw = ''
          function()
            local path = vim.fn.input("Enter new directory path: ", vim.fn.getcwd(), "dir")
            path = vim.fn.fnamemodify(path, ":p")  -- Normalize to absolute path
            if vim.fn.isdirectory(path) == 1 then
              vim.cmd("cd " .. vim.fn.fnameescape(path))
              vim.notify("Changed directory to " .. path, vim.log.levels.INFO)
              require("telescope.builtin").find_files({ cwd = path })
            else
              vim.notify("Invalid directory: " .. path, vim.log.levels.ERROR)
            end
          end, { desc = "Change directory and execute Telescope find_files" }
        '';
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>cg";
        action.__raw = ''
          function()
            local path = vim.fn.input("Enter new directory path: ", vim.fn.getcwd(), "dir")
            path = vim.fn.fnamemodify(path, ":p")  -- Normalize to absolute path
            if vim.fn.isdirectory(path) == 1 then
              vim.cmd("cd " .. vim.fn.fnameescape(path))
              vim.notify("Changed directory to " .. path, vim.log.levels.INFO)
              require("telescope.builtin").live_grep({ cwd = path })
            else
              vim.notify("Invalid directory: " .. path, vim.log.levels.ERROR)
            end
          end, { desc = "Change directory and execute Telescope live_grep" }
        '';
        options.silent = true;
      }
    ];
  };
in
{
  flake.modules.homeManager.editors.programs.nixvim = mod;
  flake.modules.nixos.editors.programs.nixvim = mod;
  flake.modules.generic.package = mod;
}
