{ inputs }:
{ device, deviceName }:
{ pkgs, lib, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
  ];
  environment.systemPackages = with pkgs; [
    disko
  ];
  disko.devices = {
    disk = {
      "${deviceName}" = {
        type = "disk";
        device = lib.mkDefault device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
