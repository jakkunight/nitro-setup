{
  disko.devices = {
    disk = {
      nitro = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          format = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            swap = {
              size = "16G";
              content = {
                type = "swap";
                discardPolicy = "both";
                priority = 100;
                resumeDevice = true; # resume from hiberation from this device
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
