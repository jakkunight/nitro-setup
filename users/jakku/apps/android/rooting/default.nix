{ pkgs, lib, config, ... }@inputs:
{
  imports = [
    ./heimdall.nix
    ./adb.nix
  ];
}
