{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Módulos de hardware
    ../../modules/system/hardware/cpu
    ../../modules/system/hardware/gpu

    # Boot, disco, kernel, red
    ../../modules/system/hardware/boot
    ../../modules/system/hardware/disk/default.nix
    ../../modules/system/hardware/kernel/linux.nix
    ../../modules/system/hardware/networking/default.nix

    # Usuario principal
    ../../users/jakku

    # Estilizado, secrets, etc.
    ../../modules/system/services/stylix
    ../../modules/system/services/sops-nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "nitro";

  time.timeZone = "America/Asuncion";
  i18n.defaultLocale = "es_PY.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "la-latin1";
    useXkbConfig = true;
  };

  environment.systemPackages = with pkgs; [
    neovim # Editor básico para emergencias
  ];

  # Esto lo define Disko
  disko.devices = import ../../modules/system/hardware/disk/layouts/nitro.nix;

  system.stateVersion = "24.05"; # Asegúrate de actualizar según tu sistema
}
