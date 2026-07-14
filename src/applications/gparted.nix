let
  feature = "gparted";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ gparted ];
    };
}
