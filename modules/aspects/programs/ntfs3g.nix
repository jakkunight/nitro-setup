let
  feature = "ntfs3g";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ ntfs3g ];
    };
}
