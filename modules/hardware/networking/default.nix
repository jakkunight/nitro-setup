{inputs, ...}: {
  flake.modules.nixos."hardware/networking" = {pkgs, ...}: {
    networking.useDHCP = true;
  };
}
