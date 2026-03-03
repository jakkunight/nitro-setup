{
  inputs,
  self,
  lib,
  ...
}:
{
  flake.modules = {
    nixos.offlineInstaller = { }: { };
  };
}
