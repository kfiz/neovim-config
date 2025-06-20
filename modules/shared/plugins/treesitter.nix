let
  mod = {
    plugins = {
      treesitter = {
        enable = true;

        nixvimInjections = true;

        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        folding = true;
      };

      treesitter-refactor = {
        enable = true;
        highlightDefinitions = {
          enable = true;
          # Set to false if you have an `updatetime` of ~100.
          clearOnCursorMove = false;
        };
      };

      hmts.enable = true;
    };
  };
in
{
  flake.modules.homeManager.editors.programs.nixvim = mod;
  flake.modules.nixos.editors.programs.nixvim = mod;
  flake.modules.generic.package = mod;
}
