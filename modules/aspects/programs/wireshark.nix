let
  feature = "wireshark";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark;
      };
      environment.systemPackages = with pkgs; [
        termshark
      ];
    };
}
