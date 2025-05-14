{
  imports = [
    ./lsp.nix
    ./lualine.nix
    ./neo-tree.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  plugins = {
    # Lazy loading
    lz-n.enable = true;

    web-devicons.enable = true;

    comment = {
      enable = true;
      settings = {
        opleader.line = "<ESC-;>";
        toggler.line = "<ESC-;>";
      };
    };
    gitsigns = {
      enable = true;
      settings.signs = {
        add.text = "+";
        change.text = "~";
      };
    };

    nvim-autopairs.enable = true;

    colorizer = {
      enable = true;
      settings.user_default_options.names = false;
    };

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
  };
}
