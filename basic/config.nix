{ config, lib, pkgs, inputs, ... }:
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
    ./../networking
    # System applications and packages:
    ./../applications
    # Graphics:
    ./../graphics
    # Sound:
    ./../sound
    # Services:
    ./../services
    # Users:
    ./../users/jakku/user.nix
  ];

  # Do not modify this!
  system.stateVersion = "24.05";
}
