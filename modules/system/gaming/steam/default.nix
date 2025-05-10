{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.gaming;
in {
  options = {
    modules.system.gaming = {
      steam.enable = lib.enableOption "Enable Steam!";
    };
  };
  config = lib.mkIf cfg.steam.enable {
    # Steam config!
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        remotePlay.openFirewall = true;
        protontricks.enable = true;
        localNetworkGameTransfers.openFirewall = true;
        extest.enable = true;
        dedicatedServer.openFirewall = true;
      };
      gamemode = {
        enable = true;
      };
      gamescope = {
        enable = true;
      };
    };
  };
}
