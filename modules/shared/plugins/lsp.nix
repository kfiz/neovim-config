let
  mod = {
    plugins = {
      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      lsp = {
        enable = true;
        inlayHints = true;
        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };
        servers = {
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          nil_ls.enable = true;
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
