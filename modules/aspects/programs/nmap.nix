let
  feature = "nmap";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nmap
        zenmap
      ];
    };
}
