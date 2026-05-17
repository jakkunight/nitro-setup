let
  feature = "steam";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        nixpkgs.config.allowUnfree = true;
        programs.nix-ld.enable = true;
        networking.firewall.allowedTCPPorts = [
          443
          3478
          5222
          8888
          27015
          27036
          31978
        ];
        networking.firewall.allowedUDPPorts = [
          443
          3478
          5222
          9999
          27015
          27031
          27036
          31978
        ];
        programs.steam = {
          enable = true;
          extest.enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          protontricks.enable = true;
        };
        environment.systemPackages = with pkgs; [
          mangohud
          wine-wayland
        ];
        programs.gamemode = {
          enable = true;
          settings = {
            general = {
              renice = 10;
            };

            custom = {
              start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
              end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
            };
          };
        };
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        nixpkgs.config.allowUnfree = true;
        home.packages = with pkgs; [
          gamemode
          steam
        ];
        programs.mangohud = {
          enable = true;
        };
      };
  };
}
