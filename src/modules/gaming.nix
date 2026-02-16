let
  moduleName = "gaming";
in
  {inputs, ...}: {
    flake.nixosModules.${moduleName} = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        heroic
        bottles
        mangohud
        discord-canary
        protonup-qt
        steam-tui
        steamcmd
      ];
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
      programs.steam = {
        enable = true;
        extest.enable = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
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
  }
