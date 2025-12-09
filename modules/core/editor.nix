{
  lib,
  config,
  inputs,
  ...
}: {
  flake.modules = {
    nixos."core/editor" = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        helix
      ];
    };
    home."core/editor" = {pkgs, ...}: {
      programs.helix = {
        enable = true;
        package = pkgs.helix;
      };
    };
  };
}
