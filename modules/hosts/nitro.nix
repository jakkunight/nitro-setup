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
                nvidia-gpu
                pipewire
                slow_network
                yorha-grub
                latest-kernel
                zram
                kanagawa-theme
                silent-sddm
                nightmare-desktop
              ]
          )
          ++ [
            (import ../_lib/disko-simple-no-swap.nix { inherit inputs; } {
              device = "/dev/nvme0n1";
              deviceName = "nitro";
            })
          ];

        hardware.nvidia.prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          sync.enable = false;
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
        };
        hardware.nvidia.powerManagement = {
          enable = lib.mkDefault true;
          finegrained = lib.mkDefault false;
        };

        nix.settings.experimental-features = lib.mkDefault [
          "nix-command"
          "flakes"
        ];
        i18n.defaultLocale = "es_PY.UTF-8";
        time.timeZone = "America/Asuncion";
        services.xserver = {
          xkb.layout = "latam";
        };
        services.libinput.enable = true;

        environment.systemPackages = with pkgs; [
          gparted-full
          helix
          yazi
          btop-cuda
          zellij
          # zellijPlugins.zjstatus
          # zellijPlugins.zjframes
        ];

        virtualisation.vmware = {
          host.enable = true;
          guest.enable = true;
        };

        services.tlp = {
          enable = true;
          pd = {
            enable = true;
          };
        };
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
