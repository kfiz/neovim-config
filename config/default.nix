{ pkgs, inputs, ... }:
{
  # Import all your configuration modules here
  imports = [
    ./plugins
    ./completion.nix
  ];
  extraPlugins =
    let
      beacon = pkgs.vimUtils.buildVimPlugin {
        name = "beacon.nvim";
        src = inputs.beacon;
      };
    in
    [ beacon ];
  extraConfigLua = "require('beacon').setup({enabled = true})";
  colorschemes.base16 = {
    enable = true;
    colorscheme = "solarized-dark";
  };
  opts = {
    autoindent = true;
    autochdir = true;
    background = "dark";
    backspace = "2";
    expandtab = true;
    number = true; # Show line
    relativenumber = true; # Show relative line numbers
    ruler = true;
    showmode = false;
    shiftwidth = 2; # Tab width should be 2
    smarttab = true;
    tabstop = 2;
  };
  autoCmd = [
    {
      event = [ "BufReadPost" ];
      pattern = [ "*" ];
      command = ''
        if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
      '';
    }
  ];
  globals.mapleader = ",";
  keymaps = [
    {
      key = "<BS>";
      action = "dh";
    }
    {
      mode = "i";
      key = "jj";
      action = "<ESC>";
    }
    {
      mode = "n";
      key = "q";
      action = ":q<CR>";
    }
    {
      mode = "n";
      key = "<CR>";
      action = ":noh<CR><ESC>";
    }
    {
      mode = "n";
      key = "<leader><leader>";
      options.silent = true;
      action = ":lua require('beacon').highlight_cursor()<CR>";
    }
    {
      mode = "n";
      key = "n";
      options.silent = true;
      action = "n:lua require('beacon').highlight_cursor()<CR>";
    }
    {
      mode = "n";
      key = "N";
      options.silent = true;
      action = "N:lua require('beacon').highlight_cursor()<CR>";
    }
    {
      mode = "n";
      key = "*";
      options.silent = true;
      action = "*:lua require('beacon').highlight_cursor()<CR>";
    }
    {
      mode = "n";
      key = "#";
      options.silent = true;
      action = "#:lua require('beacon').highlight_cursor()<CR>";
    }
  ];
}
