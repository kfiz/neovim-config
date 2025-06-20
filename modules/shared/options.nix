let
  mod = {
    clipboard = {
      # Use system clipboard
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

    opts = {
      updatetime = 100; # Faster completion

      autoindent = true;
      autochdir = true;
      background = "dark";
      backspace = "2";
      expandtab = true;
      number = true; # Show line
      relativenumber = true; # Show relative line numbers
      ruler = true;
      shiftwidth = 2; # Tab width should be 2
      showmode = false;
      smarttab = true;
      tabstop = 2;
      # Line numbers
      hidden = true; # Keep closed buffer open in the background
      splitbelow = true; # A new window is put below the current one
      splitright = true; # A new window is put right of the current one

      undofile = true; # Automatically save and restore undo history
      incsearch = true; # Incremental search: show match for partly typed search command
      inccommand = "split"; # Search and replace: preview changes in quickfix list
      ignorecase = true; # When the search query is lower-case, match both lower and upper-case
      #   patterns
      smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper
      #   case characters
      fileencoding = "utf-8"; # File-content encoding for the current buffer
      termguicolors = true; # Enables 24-bit RGB color in the |TUI|

      # Folding
      foldlevel = 99; # Folds with a level higher than this number will be closed
    };
  };
in
{
  flake.modules.homeManager.editors.programs.nixvim = mod;
  flake.modules.nixos.editors.programs.nixvim = mod;
  flake.modules.generic.package = mod;
}
