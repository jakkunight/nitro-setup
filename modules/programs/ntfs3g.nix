let
  feature = "ntfs3g";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ ntfs3g ];
    };
}
