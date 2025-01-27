# Bluetooth module:
{ lib, config, pkgs, ... }: {
  options = {
    net.bluetooth = {
      enable = lib.mkEnableOption "Enable the bluetooth connectivity.";
    };
  };
  config = lib.mkIf config.net.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman = {
      enable = true;
    };
  };
}
