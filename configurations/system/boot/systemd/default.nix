{config, ...}: let
  device = config.modules.system.hardware.boot.bootDevice;
in {
  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    inherit device;
  };
}
