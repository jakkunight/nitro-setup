let
  feature = "steam";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        nixpkgs.config.allowUnfree = true;
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
