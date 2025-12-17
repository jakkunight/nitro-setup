{
  inputs,
  lib,
  config,
  ...
}: {
  flake.modules.nixos."development/devenv" = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      devenv
    ];
  };
}
