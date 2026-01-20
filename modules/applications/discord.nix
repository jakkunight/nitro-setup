_: let
  moduleName = "applications/discord";
in {
  flake.modules = {
    nixos.${moduleName} = _: {
      home-manager.useGlobalPkgs = true;
    };
    homeManager.${moduleName} = {pkgs, ...}: {
      home.packages = with pkgs; [
        discord-rpc
        discord-canary
        discord-gamesdk
      ];
    };
  };
}
