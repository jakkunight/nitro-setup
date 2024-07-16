{ config, lib, pkgs, ... }@inputs:
{
  # Enable Flakes!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree software:
  nixpkgs.config.allowUnfree = true;
  # Import all the config for the system:
  imports = [
    ./hardware.nix
    ./../bootloader/grub2.nix
    ./../applications/info-tools.nix
    ./../applications/compressed-files.nix
    ./../applications/system-management.nix
    ./../applications/virtualization.nix
    ./../graphics/x11.nix
    ./../graphics/sddm.nix
    ./../graphics/hyprland.nix
    ./../graphics/nvidia-drivers.nix
    ./../networking/interfaces.nix
    ./../networking/hosts.nix
    ./../networking/firewall.nix
    ./../networking/vpn.nix
    ./../networking/bluetooth.nix
    ./../sound/pipewire.nix
    ./../disk/disk.nix
    ./../services/printing.nix
    ./../services/usb.nix
    ./../users/jakku/user.nix
  ];

  # Do not modify this!
  system.stateVersion = "24.05";
}
