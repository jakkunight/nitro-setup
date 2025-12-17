{
  inputs,
  config,
  lib,
  ...
}: {
  nixosHosts.nitro = {
    system = "x86_64-linux";
    users = {
      jakku = let
        systemModules = [
          "hardware/disk/layouts/simple-no-swap"
          "hardware/disk/drivers"
          "hardware/boot/grub/wanderer-themes"
          "hardware/cpu/intel"
          "hardware/kernel"
          "hardware/networking"
        ];
        homeModules = [];
      in {
        modules = systemModules ++ homeModules;
        userConfig = {
          extraGroups = [
            "wheel"
            "networkmanager"
            "input"
            "libvirtd"
            "wireshark"
          ];
        };
      };
    };
  };
}
