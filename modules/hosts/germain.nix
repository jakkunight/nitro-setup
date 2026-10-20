{
  self,
  lib,
  inputs,
  den,
  ...
}:
{
  den.hosts.x86_64-linux.germain.users = {
    ballade = { };
    jakku = {
      classes = [ "user" ];
    };
  };

  den.aspects.germain = {
    nixos =
      { pkgs, ... }:
      {
        imports =
          (
            with den.aspects;
            map
              (
                a:
                if builtins.isAttrs a && a ? nixos then
                  (
                    let
                      v = a.nixos;
                    in
                    if builtins.isAttrs v && v ? __contentValues then
                      { imports = map (d: d.value) v.__contentValues; }
                    else
                      v
                  )
                else if builtins.isAttrs a && a ? provides then
                  { }
                else
                  a
              )
              [
                intel-cpu
                disk
                bluetooth
                networking
                pipewire
                slow_network
                boot-tuning
                yorha-grub
                latest-kernel
                locale
                determinate
                pandora-theme
                haveged
                silent-sddm
                nightmare-desktop
                kde
                cinnamon
              ]
          )
          ++ [
            (import ../_lib/disko-simple-no-swap.nix { inherit inputs; } {
              device = "/dev/sda";
              deviceName = "main";
            })
          ];

      };
  };

  den.hosts.x86_64-linux.germain-offline-installer.users = {
    ballade = { };
    jakku = {
      classes = [ "user" ];
    };
  };

  den.aspects.germain-offline-installer = {
    includes = [ den.aspects.germain ];
    nixos = import ../_lib/offline-installer.nix { inherit inputs self lib; } {
      name = "germain";
    };
  };
}
