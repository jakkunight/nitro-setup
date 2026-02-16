{inputs, ...}: {
  imports = [
    inputs.disko.flakeModules.default
  ];
  flake.diskoConfigurations = {
    simpleNoSwap = {name ? throw "No device name provided. Please provide one.", device ? throw "No device specified. Please provide a device such as: '/dev/sda'"}: {
      disko = {
        devices = {
          disk = {
            "${name}" = {
              inherit device;
              type = "disk";
              content = {
                type = "gpt";
                partitions = {
                  ESP = {
                    content = {
                      format = "vfat";
                      mountOptions = [
                        "umask=0077"
                      ];
                      mountpoint = "/boot";
                      type = "filesystem";
                    };
                    size = "1G";
                    type = "EF00";
                  };
                  root = {
                    content = {
                      format = "ext4";
                      mountpoint = "/";
                      type = "filesystem";
                    };
                    size = "100%";
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
