let
  feature = "heroic";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          heroic
          mangohud
          gamemode
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        programs.mangohud = {
          enable = true;
        };
        home.packages = with pkgs; [
          heroic
          gamemode
        ];
      };
  };
}
