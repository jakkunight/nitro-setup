let
  layout = "mkSimpleNoSwapLuks";
in
{ inputs, ... }:
{
  flake.lib.diskoLayoutFactory.${layout} =
    {
      deviceName ? throw "A device name is needed. ('disk-label')",
      device ? throw "A device is needed. (/dev/sda)",
      host ? throw "A valid hostname is needed.",
    }:
    {
      nixos.${host} =
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
                    luks = {
                      size = "100%";
                      content = {
                        type = "luks";
                        name = "crypted";
                        settings.allowDiscards = true;
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
          };
        };
    };
}
