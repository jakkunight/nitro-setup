let
  feature = "anydesk";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ anydesk ];
    };
}
