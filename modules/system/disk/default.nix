# Bundle module:
{ config, lib, ... }: {
  imports = [
    ./tools
  ];
  config = {
    disk.tools.enable = lib.mkDefault true;
  };
}
