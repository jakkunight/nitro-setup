{ lib, config, ... }:
{
  imports = [
    ./steam.nix
    ./bottles.nix
  ];
  options = {
    gaming.enable = lib.mkEnableOption "Enable gaming programs";
  };
  config = lib.mkIf config.gaming.enable {
    gaming = {
      steam.enable = lib.mkDefault true;
      bottles.enable = lib.mkDefault true;
    };
  };
}
