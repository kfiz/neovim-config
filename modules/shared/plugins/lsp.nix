let
  mod =
    { lib, ... }:
    {
      lsp = {
        inlayHints.enable = true;
        keymaps =
          lib.mapAttrsToList
            (
              key: props:
              {
                inherit key;
                options.silent = true;
              }
              // props
            )
            {
              "<leader>k".action.__raw = "function() vim.diagnostic.jump({ count=-1, float=true }) end";
              "<leader>j".action.__raw = "function() vim.diagnostic.jump({ count=1, float=true }) end";
              gd.lspBufAction = "definition";
              gD.lspBufAction = "references";
              gt.lspBufAction = "type_definition";
              gi.lspBufAction = "implementation";
              K.lspBufAction = "hover";
              "<F2>".lspBufAction = "rename";
            };
        servers = {
          bashls.enable = true;
          rust_analyzer = {
            enable = true;
            config.settings."rust-analyzer" = {
              cargo.features = "all";
            };
          };
          nil_ls.enable = true;
        };
      };
      plugins = {
        lsp-format = {
          enable = true;
          lspServersToEnable = [
            "bashls"
            "rust_analyzer"
            "nil_ls"
          ];
        };
        # Sane defaults for all servers
        lspconfig.enable = true;
      };
    };
in
{
  flake.modules.homeManager.default.programs.nixvim = mod;
  flake.modules.nixos.default.programs.nixvim = mod;
  flake.modules.generic.package = mod;
}
