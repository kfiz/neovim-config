{
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
      key = "<leader>cf";
      action.__raw = ''
        function()
          local path = vim.fn.input("Enter new directory path: ", "", "dir")
          if vim.fn.isdirectory(path) == 1 then
            vim.cmd("cd " .. vim.fn.fnameescape(path))
            vim.notify("Changed directory to " .. path)
            vim.cmd("Telescope find_files")
          else
            vim.notify("Invalid directory: " .. path, vim.log.levels.ERROR)
          end
        end, { desc = "Change directory and execute Telescope find_files" }
      '';
      # action = ":exec 'cd' . expand('%:p:h')<CR>:Telescope find_files<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>cg";
      action.__raw = ''
        function()
          local path = vim.fn.input("Enter new directory path: ", "", "dir")
          if vim.fn.isdirectory(path) == 1 then
            vim.cmd("cd " .. vim.fn.fnameescape(path))
            vim.notify("Changed directory to " .. path)
            vim.cmd("Telescope live_grep")
          else
            vim.notify("Invalid directory: " .. path, vim.log.levels.ERROR)
          end
        end, { desc = "Change directory and execute Telescope live_grep" }
      '';
      options.silent = true;
    }
  ];
}
