{ inputs }:
{ device, deviceName }:
{ pkgs, ... }:
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
        inherit device;
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
