# Neovim setup.
# Choose between your Neovim flavors!
{ lib, config, ... }: {
  imports = [
    ./nvf
    ./vanilla
  ];
  options = {
    terminal.editor.nvim = {
      enable = lib.mkEnableOption "Enable Neovim";
      default = lib.mkEnableOption "Make Neovim your default editor.";
      flavor = lib.mkOption {
        description = "Choose your Neovim flavor for NixOS!";
        type = lib.types.enum [
          "nvf"
          "vanilla"
        ];
        default = "nvf";
      };
    };
  };
  config = lib.mkIf config.terminal.editor.nvim.enable {
    terminal.editor.nvim = {
      nvf.enable = config.terminal.editor.nvim.flavor == "nvf";
      vanilla.enable = config.terminal.editor.nvim.flavor == "vanilla";
    };
    environment.sessionVariables = (
      if config.terminal.editor.nvim.default
      then {
        EDITOR = "nvim";
      }
      else {}
    );
  };
}
