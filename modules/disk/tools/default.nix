{ lib, config, inputs, pkgs, ... }:
{
  options = {
    disk.tools = {
      enable = lib.mkEnableOption "Enable disk management tools.";
    };
  };
  config = lib.mkIf config.disk.tools.enable {
    environment.systemPackages = [
      pkgs.gparted
      pkgs.parted
      pkgs.dust
      pkgs.ncdu
      pkgs.dua
    ];
  };
}
