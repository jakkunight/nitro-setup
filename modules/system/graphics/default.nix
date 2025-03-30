# Graphics settings:
{ lib, config, ... }: {
  imports = [
    ./display-manager
    ./wm
    ./nvidia
    ./nerdfonts.nix
  ];
  options = {
    graphics = {
      enable = lib.mkEnableOption "Enable graphic system";
    };
  };
  config = lib.mkIf config.graphics.enable {
    graphics = {
      display-manager.enable = lib.mkDefault true;
      wm.enable = lib.mkDefault true;
      nvidia.enable = lib.mkDefault false;
      fonts.enable = lib.mkDefault true;
    };
  };
}
