{
  # Import all your configuration modules here
  imports = [
    ./plugins
    ./completion.nix
  ];
  colorschemes.base16 = {
    enable = true;
    colorscheme = "solarized-dark";
  };
  opts = {
    autoindent = true;
    autochdir = true;
    background = "dark";
    shiftwidth = 2; # Tab width should be 2
    expandtab = true;
    tabstop = 2;
    number = true; # Show line numbers
    relativenumber = true; # Show relative line numbers
    showmode = false;
    ruler = true;
  };
  globals.mapleader = " ";
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
  ];
}
