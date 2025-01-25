# Editor setup:
{ lib, config, ... }: {
  imports = [
    ./micro.nix
    ./helix.nix
    ./nvim
  ];
  options = {
    terminal.editor = {
      enable = lib.mkEnableOption "Enable more terminal editors";
    };
  };
  config = lib.mkIf config.terminal.editor.enable {
    terminal.editor = {
      micro = {
        enable = lib.mkDefault true;
        default = lib.mkDefault false;
      };
      helix = {
        enable = lib.mkDefault true;
        default = lib.mkDefault false;
      };
      nvim = {
        enable = lib.mkDefault true;
        default = lib.mkDefault true;
        flavor = lib.mkDefault "nvf";
      };
    };
  };
}
