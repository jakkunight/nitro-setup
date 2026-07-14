let
  feature = "nmap";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nmap
        zenmap
      ];
    };
}
