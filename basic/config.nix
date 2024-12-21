{ config, lib, pkgs, inputs, modulesPath,  ... }:
{
  # Enable Flakes!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree software:
  nixpkgs.config.allowUnfree = true;
  # Use NixOS-Generators:
  environment.systemPackages = [
    pkgs.nixos-generators
    pkgs.calamares-nixos
    pkgs.calamares
    pkgs.calamares-nixos-extensions
  ];
  # Import all the config for the system:
  imports = [
    # Basic:
    ./hardware.nix
    ./i18n.nix
    ./../bootloader
    # Disk:
    #./../disk/disk.nix
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
