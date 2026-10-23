{
  self,
  lib,
  inputs,
  den,
  ...
}:
{
  den.hosts.x86_64-linux.nitro.users.jakku = {
    classes = [ "user" ];
  };

  den.aspects.nitro = {
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
                dns-over-tls
                nvidia-gpu
                nvidia-prime
                pipewire
                slow_network
                boot-tuning
                yorha-grub
                latest-kernel
                locale
                tlp
                vmware
                zram
                kanagawa-theme
                haveged
                silent-sddm
                nightmare-desktop
                # wireguard-client
                # remote-deploy-client
              ]
          )
          ++ [
            (import ../_lib/disko-simple-no-swap.nix { inherit inputs; } {
              device = lib.mkDefault "/dev/nvme0n1";
              deviceName = "nitro";
            })
          ];

        nix.settings.experimental-features = lib.mkDefault [
          "nix-command"
          "flakes"
        ];

        environment.systemPackages = with pkgs; [
          gparted-full
          helix
          yazi
          btop-cuda
          zellij
          # zellijPlugins.zjstatus
          # zellijPlugins.zjframes
        ];
      };
  };

  den.hosts.x86_64-linux.nitro-offline-installer.users.jakku = {
    classes = [ "user" ];
  };

  den.aspects.nitro-offline-installer = {
    includes = [ den.aspects.nitro ];
    nixos = import ../_lib/offline-installer.nix { inherit inputs self lib; } {
      name = "nitro";
    };
  };
}
