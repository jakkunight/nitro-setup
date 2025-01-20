{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./grub2.nix
    ./filesystems.nix
    ./kernel.nix
  ];
}
