let
  feature = "exfat-progs";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        exfatprogs
        exfat
      ];
    };
}
