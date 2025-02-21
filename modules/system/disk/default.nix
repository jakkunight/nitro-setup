# Bundle module:
{ config, lib, ... }: {
  imports = [
    ./filesystems.nix
    ./tools
  ];
  config = {
    disk.tools.enable = lib.mkDefault true;
  };
}
