let
  feature = "kdenlive";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        kdePackages.kdenlive
      ];
    };
  flake.modules.homeManager.${feature} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        kdePackages.kdenlive
      ];
    };
}
