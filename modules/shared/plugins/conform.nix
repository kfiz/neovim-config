let
  mod =
    { pkgs, lib, ... }:
    {
      plugins.conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            bash = [
              "shellcheck"
              "shellharden"
              "shfmt"
            ];
            nix = [
              "nixfmt"
            ];
            rust = [
              "rustfmt"
            ];
            javascript = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              timeout_ms = 2000;
              stop_after_first = true;
            };
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };
          format_on_save = # Lua
            ''
              function(bufnr)
                -- initialize the table once
                vim.g._slow_format_filetypes = vim.g._slow_format_filetypes or {}

                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                local ft = vim.bo[bufnr].filetype
                if vim.g._slow_format_filetypes[ft] then
                  return
                end

                local function on_format(err)
                  if err and err:match("timeout$") then
                    vim.g._slow_format_filetypes[ft] = true
                    vim.notify("Formatting timed out for " .. ft .. ". Marked as slow.", vim.log.levels.WARN)
                  end
                end

                return { timeout_ms = 200, lsp_fallback = true }, on_format
               end
            '';
          format_after_save = # Lua
            ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                if not vim.g._slow_format_filetypes[ft] then
                  return
                end

                return { lsp_fallback = true }
              end
            '';
          log_level = "warn";
          notify_on_error = false;
          notify_no_formatters = false;
          formatters = {
            shellcheck = {
              command = lib.getExe pkgs.shellcheck;
            };
            shfmt = {
              command = lib.getExe pkgs.shfmt;
            };
            shellharden = {
              command = lib.getExe pkgs.shellharden;
            };
            nixfmt = {
              command = "nixfmt"; # lib.getExe pkgs.nixfmt-rfc-style;
            };
            rustfmt = {
              command = lib.getExe pkgs.rustfmt;
            };
            squeeze_blanks = {
              command = lib.getExe' pkgs.coreutils "cat";
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
