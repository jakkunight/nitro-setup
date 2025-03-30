# Display Manager configuration:
{ lib, config, ... }: {
  imports = [
    ./sddm
  ];
  options = {
    graphics.display-manager = {
      enable = lib.mkEnableOption "Enable the display manager";
    };
  };
  config = lib.mkIf config.graphics.display-manager.enable {
    graphics.display-manager = {
      sddm.enable = lib.mkDefault true;
    };
  };
}
