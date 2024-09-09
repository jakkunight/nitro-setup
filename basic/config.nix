{ config, lib, pkgs, inputs, ... }@args:
{
  # Enable Flakes!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree software:
  nixpkgs.config.allowUnfree = true;
  # Import all the config for the system:
  imports = [
    # Basic:
    ./hardware.nix
    ./i18n.nix
    ./../bootloader/grub2.nix
    ./../bootloader/kernel_version.nix
    # Disk:
    ./../disk/disk.nix
    # Networking:
    ./../networking/common.nix
    ./../networking/interfaces.nix
    ./../networking/hosts.nix
    ./../networking/firewall.nix
    ./../networking/vpn-connections/andescada.nix
    ./../networking/vpn-connections/cloudflare-warp.nix
    ./../networking/bluetooth.nix
    # System applications and packages:
    ./../applications
    # Graphics:
    ./../graphics/x11.nix
    ./../graphics/nvidia-drivers.nix
    ./../graphics/sddm.nix
    ./../graphics/hyprland.nix
    # Sound:
    ./../sound
    # Services:
    ./../services/printing.nix
    ./../services/usb.nix
    ./../services/tlp.nix
    ./../services/flatpak.nix
    ./../services/virtualization.nix
    # Users:
    ./../users/jakku/user.nix
  ];

  # Do not modify this!
  system.stateVersion = "24.05";
}
