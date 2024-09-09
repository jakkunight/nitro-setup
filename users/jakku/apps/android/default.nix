{ pkgs, lib, config, ... }@inputs:
{
  imports = [
    ./dev
    ./rooting
  ];
}
