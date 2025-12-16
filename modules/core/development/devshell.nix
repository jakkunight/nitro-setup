{
  inputs,
  lib,
  config,
  ...
}: {
  flake.modules.nixos."development/devenv" = {pkgs, ...}: {};
}
