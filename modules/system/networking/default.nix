{
  config,
  lib,
  ...
}: {
  imports = [];
  networking.useDHCP = lib.mkDefault true;
}
