let
  feature = "gimp";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gimp
      ];
    };
  flake.modules.homeManager.${feature} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gimp
      ];
    };

}
