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
          "boot/grub/wanderer-theme"
        ];
        homeModules = [];
      in {
        modules = systemModules ++ homeModules;
        userConfig = {
        };
      };
    };
  };
}
