{ lib, config, pkgs, inputs, ... }:
{
  options = {
    development = {
      enable = lib.mkEnableOption "Enable the development tools";
    };
  };
  config = lib.mkIf config.development.enable {
    environment.systemPackages = [
      pkgs.devenv
      pkgs.nix-ld
      pkgs.direnv
    ];
  };
}
