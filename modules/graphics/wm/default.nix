{ lib, config, ... }: {
  imports = [
    ./hyprland
  ];
  options = {
    graphics.wm = {
      enable = lib.mkEnableOption "Enable the Window Manager support.";
    };
  };
  config = lib.mkIf config.graphics.wm.enable {
    graphics.wm = {
      hyprland.enable = lib.mkDefault true;
    };
  };
}
