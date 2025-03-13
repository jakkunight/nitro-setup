# Steam!
{ lib, config, pkgs, ... }:
{
  options = {
    gaming.steam = {
      enable = lib.mkEnableOption "Enable Steam!";
    };
  };
  config = lib.mkIf config.gaming.steam.enable {
    programs = {
      gamescope = {
        enable = true;
      };
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        dedicatedServer.openFirewall = true;
        extraPackages = with pkgs; [
          gamescope
        ];
        gamescopeSession = {
          enable = true;
        };
      };
    };
  };
}
