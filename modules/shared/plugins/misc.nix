let
  mod = {
    colorschemes.base16 = {
      enable = true;
      colorscheme = "solarized-dark";
    };

    plugins = {
      colorizer = {
        enable = true;
        settings.user_default_options.names = false;
      };

      comment = {
        enable = true;
        settings = {
          opleader.line = "<M-S-,>";
          toggler.line = "<M-S-,>";
        };
      };

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      # Lazy loading
      lz-n.enable = true;

      nvim-autopairs.enable = true;

      oil = {
        enable = true;
        lazyLoad.settings.cmd = "Oil";
      };

      trim = {
        enable = true;
        settings = {
          highlight = true;
          ft_blocklist = [
            "checkhealth"
            "lspinfo"
            "TelescopePrompt"
          ];
        };
      };

      web-devicons.enable = true;
      which-key.enable = true;
    };
  };
in
{
  flake.modules.homeManager.default.programs.nixvim = mod;
  flake.modules.nixos.default.programs.nixvim = mod;
  flake.modules.generic.package = mod;
}
