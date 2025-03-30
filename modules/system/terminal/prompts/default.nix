# Terminal prompts:
{ lib, config, ... }: {
  imports = [
    ./starship.nix
  ];
  options = {
    terminal = {
      prompts = {
        enable = lib.mkEnableOption "Enable custom shell prompts";
      };
    };
  };
  config = lib.mkIf config.terminal.prompts.enable {
    terminal.prompts = {
      starship.enable = lib.mkDefault true;
    };
  };
}
